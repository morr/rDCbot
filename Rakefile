# Get your spec rake tasks working in RSpec 2.0
require 'rubygems'
require 'rake/gempackagetask'
#require 'spec/rake/spectask'
require 'rubygems/specification'
require 'date'

GEM = "rdcbot"
GEM_VERSION = "0.0.1"
AUTHOR = "Andrey Sidorov"
EMAIL = "takandar@gmail.com"
HOMEPAGE = "https://github.com/morr/rDCbot"
SUMMARY = "Bot for the Direct Connect(DC) protocol"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", "CHANGELOG", "TODO"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  # Uncomment this to add a dependency
  # s.add_dependency "foo"

  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README CHANGELOG TODO Rakefile) + Dir.glob("{lib,spec}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

task 'test:units' => :spec

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  # Put spec opts in a file named .rspec in root
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.pattern = "./spec/**/*_spec.rb" # don't need this, it's default.
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
