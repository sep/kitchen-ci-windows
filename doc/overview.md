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

### Supported Vagrant Boxes


### Future Work
+ Automate installing the Jenkins Slave service
* Install Packer to create Vagrant boxes
