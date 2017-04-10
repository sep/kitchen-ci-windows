# Cookbook:: kitchen-ci-windows

packages_installed = ['vagrant',
                      'Oracle VM VirtualBox 5.1.18',
                      'Chef Development Kit v1.2.20',
                      'Google Chrome']

packages_installed.each do |x|
  describe package(x) do
    it { should be_installed }
  end
end

script = <<-EOH
  vagrant -v
  vagrant plugin list
EOH

describe powershell(script) do
  its('stdout') { should match 'Vagrant 1.9.2.*' }
  its('stdout') { should match '.*vagrant-winrm.*' }
end

describe directory 'c:\\jenkins' do
  it { should exist }
end

describe windows_feature('NET-Framework-Core') do
  it { should be_installed }
end

describe file('C:\\Windows\\System32\\PsExec.exe') do
  it { should exist }
end

describe directory 'C:\\Windows\\SysWOW64\\config\\systemprofile\.chef' do
  it { should exist }
end
