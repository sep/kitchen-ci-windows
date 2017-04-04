# common things to install

# choco Packages
default['kitchen-ci-windows']['packages']['vagrant']['version'] = '1.9.2'
default['kitchen-ci-windows']['packages']['vagrant']['reboot'] = true
default['kitchen-ci-windows']['packages']['virtualbox']['version'] = '5.1.18'

# Java
default['java']['windows']['url'] = 'file:///c:/Installers/jdk-8u51-windows-x64.exe'
default['java']['windows']['checksum'] = 'F01FD26E6C0936A0F928385C61046D6F97EB32C79BF1EC7C11F105BA8147BE87'

# Chefdk
default['kitchen-ci-windows']['chefdk']['url'] = 'https://packages.chef.io/files/stable/chefdk/1.2.20/windows/2012r2/chefdk-1.2.20-1-x86.msi'
default['kitchen-ci-windows']['chefdk']['checksum'] = '155c18d8e67ff1a77049c3399f2eada2d17553a6afaf6ad5266540a8f1acfc96'
