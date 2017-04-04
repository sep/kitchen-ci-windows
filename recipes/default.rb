#
# Cookbook:: kitchen-ci-windows
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'java-oracle::default'
include_recipe 'chocolatey'

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
end
