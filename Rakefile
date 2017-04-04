#!/usr/bin/env rake

# Style tests. cookstyle (rubocop) and Foodcritic
namespace :style do
  begin
    require 'cookstyle'
    require 'rubocop/rake_task'

    desc 'Run Ruby style checks'
    RuboCop::RakeTask.new(:ruby)
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV['CI']
  end

  begin
    require 'foodcritic'

    desc 'Run Chef style checks'
    FoodCritic::Rake::LintTask.new(:chef) do |t|
      t.options = {
        fail_tags: ['any'],
        progress: true
      }
    end
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV['CI']
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# ChefSpec
begin
  require 'rspec/core/rake_task'

  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => e
  puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV['CI']
end

# Integration tests. Kitchen.ci
namespace :integration do
  begin
    require 'kitchen/rake_tasks'

    desc 'Run kitchen integration tests'
    Kitchen::RakeTasks.new
  rescue LoadError, StandardError => e
    puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV['CI']
  end
end

namespace :berkshelf do
  desc 'Install berkshelf cookbooks locally'
  task :install do
    require 'berkshelf'
    require 'berkshelf/berksfile'
    current_dir = File.expand_path('../', __FILE__)
    berksfile_path = File.join(current_dir, 'Berksfile')
    berksfile = Berkshelf::Berksfile.from_file(berksfile_path)
    berksfile.install
  end

  task :upload do
    require 'berkshelf'
    require 'berkshelf/berksfile'
    current_dir = File.expand_path('../', __FILE__)
    berksfile_path = File.join(current_dir, 'Berksfile')
    berksfile = Berkshelf::Berksfile.from_file(berksfile_path)
    berksfile.upload
  end
end

require 'knife_cookbook_doc/rake_task'

# With default options
KnifeCookbookDoc::RakeTask.new(:doc)

# Example with custom options
KnifeCookbookDoc::RakeTask.new(:doc) do |t|
  t.options[:cookbook_dir] = './'
  t.options[:constraints] = true
  t.options[:output_file] = 'README.md'
end

# Default
task default: %w(style integration:kitchen:all)

task build: %w(style integration:kitchen:all berkshelf:install berkshelf:upload)
