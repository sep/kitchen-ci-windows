#
# Cookbook:: kitchen-ci-windows
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'
recipes = ['kitchen-ci-windows::default', 'kitchen-ci-windows::java']

recipes.each do |r|
  describe r do
    context 'Converge successfully on Windows' do
      let(:chef_run) do
        runner = ChefSpec::SoloRunner.new(platform: 'Windows', version: '2012R2')
        runner.converge(described_recipe)
      end

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
    end
  end
end
