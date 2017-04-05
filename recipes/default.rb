#
# Cookbook:: kitchen-ci-windows
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# There is something wrong with the java cookbook. So I either need to update
# the community one or update the wrapper to just install the pacakge
include_recipe 'java-oracle::default'
include_recipe 'chocolatey'
include_recipe 'git-wrapper'

reboot 'Restart Computer' do
  action :nothing
end

node['kitchen-ci-windows']['packages'].each do |key, value|
  chocolatey_package key do
    version value['version']
    action :install
    retries 1
    notifies :request_reboot, 'reboot[Restart Computer]' if value['reboot']
  end
end

package 'chef_dk' do
  action :install
  source node['kitchen-ci-windows']['chefdk']['url']
  checksum node['kitchen-ci-windows']['chefdk']['checksum']
end

directory 'c:\\jenkins' do
  action :create
end

dsc_resource 'NET-Framework-Core' do
  resource :windowsfeature
  property :ensure, 'Present'
  property :name, 'NET-Framework-Core'
  property :source, 'c:\\Installers'
end

# TODO: Add a check to see if this service is installed and only do this
windows_service 'jenkinsslave-c__jenkins' do
  action :start
end

chef_gem 'knife-cookbook-doc' do
  action :install
end

cookbook_file 'C:\\Windows\\System32\\PsExec.exe' do
  source 'PsExec.exe'
  action :create_if_missing
end

powershell_script 'install vagrant winrm plugin' do
  code <<-EOH
    vagrant plugin install vagrant-winrm
  EOH
end

directory 'C:\Windows\System32\config\systemprofile\.vagrant.d' do
  action :create
end

directory 'C:\\Windows\\SysWOW64\\config\\systemprofile\\.vagrant.d' do
  action :create
end

node['kitchen-ci-windows']['vagrant-box'].each do |key, value|
  powershell_script "Adding #{key} Vagrant box" do
    code <<-EOH
      vagrant box add #{value} --name #{key}

      $src_dir = "C:\\Windows\\SysWOW64\\config\\systemprofile\\.vagrant.d"
      $dst_dir = "C:\\Windows\\System32\\config\\systemprofile\\.vagrant.d"
      robocopy   $src_dir $dst_dir /MIR
    EOH
    not_if "Test-Path C:\\Windows\\System32\\config\\systemprofile\\.vagrant.d\\boxes\\C-VAGRANTCOLON-\\Vagrant-Boxes\\#{key}"
  end
end
