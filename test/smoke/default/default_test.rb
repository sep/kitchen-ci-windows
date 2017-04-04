#
# Cookbook:: kitchen-ci-windows

packages_installed = ['vagrant',
                      'Oracle VM VirtualBox 5.1.18',
                      'Chef Development Kit v1.2.20']

packages_installed.each do |x|
  describe package(x) do
    it { should be_installed }
  end
end

script = <<-EOH
  vagrant -v
EOH

describe powershell(script) do
  its('stdout') { should match 'Vagrant 1.9.2.*' }
end
