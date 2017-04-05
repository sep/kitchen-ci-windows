# Description

Installs/Configures kitchen-ci-windows

# Requirements

## Platform:

* windows (= 2016)

## Cookbooks:

* chocolatey (~> 1.1.0)
* java-oracle (~> 0.1.1)
* git-wrapper (~> 0.1.0)

# Attributes

* `node['kitchen-ci-windows']['packages']['vagrant']['version']` -  Defaults to `1.9.2`.
* `node['kitchen-ci-windows']['packages']['vagrant']['reboot']` -  Defaults to `true`.
* `node['kitchen-ci-windows']['packages']['virtualbox']['version']` -  Defaults to `5.1.18`.
* `node['kitchen-ci-windows']['packages']['googlechrome']['version']` -  Defaults to `nil`.
* `node['java']['windows']['url']` -  Defaults to `file:///c:/Installers/jdk-8u51-windows-x64.exe`.
* `node['java']['windows']['checksum']` -  Defaults to `F01FD26E6C0936A0F928385C61046D6F97EB32C79BF1EC7C11F105BA8147BE87`.
* `node['kitchen-ci-windows']['chefdk']['url']` -  Defaults to `https://packages.chef.io/files/stable/chefdk/1.2.20/windows/2012r2/chefdk-1.2.20-1-x86.msi`.
* `node['kitchen-ci-windows']['chefdk']['checksum']` -  Defaults to `155c18d8e67ff1a77049c3399f2eada2d17553a6afaf6ad5266540a8f1acfc96`.
* `node['kitchen-ci-windows']['vagrant-box']['OC_Win10']` -  Defaults to `C:\\Vagrant-Boxes\\OC_windows_10_virtualbox_0.3.0.box`.

# Recipes

* kitchen-ci-windows::default

# License and Maintainer

Maintainer:: Bob Nowadly (<rmnowadly@sep.com>)
Source:: https://github.com/sep/kitchen-ci-windows
Issues:: https://github.com/sep/kitchen-ci-windows/issues

License:: Apache license 2.0
