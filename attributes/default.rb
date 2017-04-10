# common things to install
# choco Packages
default['kitchen-ci-windows']['packages']['vagrant']['version'] = '1.9.2'
default['kitchen-ci-windows']['packages']['virtualbox']['version'] = '5.1.18'
# nil will install latest
default['kitchen-ci-windows']['packages']['googlechrome']['version'] = nil

# Java
default['java']['windows']['url'] = 'file:///c:/Installers/jdk-8u51-windows-x64.exe'
default['java']['windows']['checksum'] = 'F01FD26E6C0936A0F928385C61046D6F97EB32C79BF1EC7C11F105BA8147BE87'
default['java']['windows']['package_name'] = 'Java SE Development Kit 8 Update 51 (64-bit)'

# Chefdk
default['kitchen-ci-windows']['chefdk']['url'] = 'https://packages.chef.io/files/stable/chefdk/1.2.20/windows/2012r2/chefdk-1.2.20-1-x86.msi'
default['kitchen-ci-windows']['chefdk']['checksum'] = '155c18d8e67ff1a77049c3399f2eada2d17553a6afaf6ad5266540a8f1acfc96'

# vagrant boxes
default['kitchen-ci-windows']['vagrant-box']['OC_Win10'] = 'C:\\Vagrant-Boxes\\OC_windows_10_virtualbox_0.3.0.box'
default['kitchen-ci-windows']['vagrant-box']['win2016'] = 'C:\\Vagrant-Boxes\\windows2016min-virtualbox.box'
default['kitchen-ci-windows']['vagrant-box']['win10'] = 'C:\\Vagrant-Boxes\\windows_10_virtualbox_v1.0.0.box'

default['kitchen-ci-windows']['vagrant-homex64'] = 'C:\\Windows\\SysWOW64\\config\\systemprofile'
default['kitchen-ci-windows']['vagrant-homex86'] = 'C:\\Windows\\System32\\config\\systemprofile'

default['kitchen-ci-windows']['jenkins-service'] = 'jenkinsslave-c__jenkins'
# rubocop:enable LineLength
