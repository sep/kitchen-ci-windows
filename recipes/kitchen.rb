include_recipe 'chocolatey'
include_recipe 'git-wrapper'

TMP_DIR = 'C:\\kitchen-ci-windows'.freeze

node['kitchen-ci-windows']['packages'].each do |key, value|
  chocolatey_package key do
    version value['version']
    action :install
    retries 1
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

directory TMP_DIR do
  action :create
end

cookbook_file "#{TMP_DIR}\\microsoft-windows-netfx3-ondemand-package.cab" do
  source 'microsoft-windows-netfx3-ondemand-package.cab'
end

dsc_resource 'NET-Framework-Core' do
  resource :windowsfeature
  property :ensure, 'Present'
  property :name, 'NET-Framework-Core'
  property :source, TMP_DIR
end

cookbook_file 'C:\\Windows\\System32\\PsExec.exe' do
  source 'PsExec.exe'
  action :create_if_missing
end

vagrant_homex64 = "#{node['kitchen-ci-windows']['vagrant-homex64']}\\.vagrant.d"
vagrant_homex86 = "#{node['kitchen-ci-windows']['vagrant-homex86']}\\.vagrant.d"
chef_homex64 = "#{node['kitchen-ci-windows']['vagrant-homex64']}\\.chef"
chef_homex86 = "#{node['kitchen-ci-windows']['vagrant-homex86']}\\.chef"
kitchen_homex64 = "#{node['kitchen-ci-windows']['vagrant-homex64']}\\.kitchen"
kitchen_homex86 = "#{node['kitchen-ci-windows']['vagrant-homex86']}\\.kitchen"

dsc_resource 'VAGRANT_HOME' do
  resource :environment
  property :ensure, 'Present'
  property :name, 'VAGRANT_HOME'
  property :value, vagrant_homex86
end

# Set VAGRANT_HOME for this process
ENV['VAGRANT_HOME'] = vagrant_homex86

directory vagrant_homex86 do
  action :create
end

directory vagrant_homex64 do
  action :create
end

directory chef_homex64 do
  action :create
end

directory chef_homex86 do
  action :create
end

directory kitchen_homex64 do
  action :create
end

directory kitchen_homex86 do
  action :create
end

powershell_script 'install vagrant winrm plugin' do
  code <<-EOH
    C:\\HashiCorp\\Vagrant\\bin\\vagrant plugin install vagrant-winrm
  EOH
end

link vagrant_homex86 do
  to vagrant_homex64
end

link chef_homex64 do
  to chef_homex86
end

link kitchen_homex86 do
  to kitchen_homex64
end

node['kitchen-ci-windows']['vagrant-box'].each do |key, value|
  powershell_script "Adding #{key} Vagrant box" do
    code <<-EOH
      if (-not (Test-Path '#{vagrant_homex86}\\boxes\\#{key}')) {
        C:\\HashiCorp\\Vagrant\\bin\\vagrant box add #{value} --name #{key} --force
      }
    EOH
  end
end

windows_service node['kitchen-ci-windows']['jenkins-service'] do
  action :start
end
