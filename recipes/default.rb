#
# Cookbook:: kitchen-ci-windows
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

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

windows_service node['kitchen-ci-windows']['jenkins-service'] do
  action :start
end

chef_gem 'knife-cookbook-doc' do
  action :install
end

cookbook_file 'C:\\Windows\\System32\\PsExec.exe' do
  source 'PsExec.exe'
  action :create_if_missing
end

vagrant_homex64 = "#{node['kitchen-ci-windows']['vagrant-homex64']}\\.vagrant.d"
vagrant_homex86 = "#{node['kitchen-ci-windows']['vagrant-homex86']}\\.vagrant.d"

dsc_resource 'VAGRANT_HOME' do
  resource :environment
  property :ensure, 'Present'
  property :name, 'VAGRANT_HOME'
  property :value, vagrant_homex86
end

directory vagrant_homex86 do
  action :create
end

directory vagrant_homex64 do
  action :create
end

powershell_script 'install vagrant winrm plugin' do
  code <<-EOH
    vagrant plugin install vagrant-winrm
  EOH
end

link vagrant_homex86 do
  to vagrant_homex64
end

node['kitchen-ci-windows']['vagrant-box'].each do |key, value|
  powershell_script "Adding #{key} Vagrant box" do
    code <<-EOH
      if (-not (Test-Path '#{vagrant_homex86}\\boxes\\#{key}')) {
        vagrant box add #{value} --name #{key} --force
      }
    EOH
  end
end
