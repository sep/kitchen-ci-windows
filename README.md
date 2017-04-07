# Description

This cookbook is used for configuring a Jenkins Slave that will be used to
test Chef Cookbooks. However, it does not automate the installation of the
Jenkins service. That might come at a later time.

### What does it do?

+ Installs Java
+ Installs Chefdk
+ Installs git
+ Installs Git Extensions
+ Installs Chocolatey
+ Installs Vagrant
+ Installs Virtualbox
+ Configures Vagrant to work correctly when run as the Local System User
+ Configures Dependencies for the Jenkins Slave
+ Starts Jenkins Slave if it is not running
+ Adds Vagrant boxes that can be used by Jenkins builds

### Cookbook Assumptions
+ Vagrant Boxes will be manually copied into C:\Vagrant-Boxes before a chef run on the Jenkins Slave
+ The JDK installer is manually copied into C:\Installers on the Jenkins Slave
+ The Jenkins Slave will be installed manually using the jnlp downloaded from the
server. This will need to be installed after the first Chef run. (which will fail
  because the Jenkins service is not installed)
+ The cookbook will be executed as the Local System Account.

### Future Work
+ Automate installing the Jenkins Slave service
* Install Packer to create Vagrant boxes

# Requirements

## Platform:

* windows (= 2016)

## Cookbooks:

* chocolatey (~> 1.1.0)
* java-oracle (~> 0.1.1)
* git-wrapper (~> 0.1.0)

# Attributes

* `node['kitchen-ci-windows']['packages']['vagrant']['version']` -  Defaults to `1.9.2`.
* `node['kitchen-ci-windows']['packages']['virtualbox']['version']` -  Defaults to `5.1.18`.
* `node['kitchen-ci-windows']['packages']['googlechrome']['version']` -  Defaults to `nil`.
* `node['java']['windows']['url']` -  Defaults to `file:///c:/Installers/jdk-8u51-windows-x64.exe`.
* `node['java']['windows']['checksum']` -  Defaults to `F01FD26E6C0936A0F928385C61046D6F97EB32C79BF1EC7C11F105BA8147BE87`.
* `node['java']['windows']['package_name']` -  Defaults to `Java SE Development Kit 8 Update 51 (64-bit)`.
* `node['kitchen-ci-windows']['chefdk']['url']` -  Defaults to `https://packages.chef.io/files/stable/chefdk/1.2.20/windows/2012r2/chefdk-1.2.20-1-x86.msi`.
* `node['kitchen-ci-windows']['chefdk']['checksum']` -  Defaults to `155c18d8e67ff1a77049c3399f2eada2d17553a6afaf6ad5266540a8f1acfc96`.
* `node['kitchen-ci-windows']['vagrant-box']['OC_Win10']` -  Defaults to `C:\\Vagrant-Boxes\\OC_windows_10_virtualbox_0.3.0.box`.
* `node['kitchen-ci-windows']['vagrant-box']['win2016']` -  Defaults to `C:\\Vagrant-Boxes\\windows2016min-virtualbox.box`.
* `node['kitchen-ci-windows']['vagrant-homex64']` -  Defaults to `C:\\Windows\\SysWOW64\\config\\systemprofile`.
* `node['kitchen-ci-windows']['vagrant-homex86']` -  Defaults to `C:\\Windows\\System32\\config\\systemprofile`.
* `node['kitchen-ci-windows']['jenkins-service']` -  Defaults to `jenkinsslave-c__jenkins`.

# Recipes

* kitchen-ci-windows::default
* kitchen-ci-windows::java
* kitchen-ci-windows::kitchen

# License and Maintainer

Maintainer:: Bob Nowadly (<rmnowadly@sep.com>)
Source:: https://github.com/sep/kitchen-ci-windows
Issues:: https://github.com/sep/kitchen-ci-windows/issues

License:: Apache license 2.0
