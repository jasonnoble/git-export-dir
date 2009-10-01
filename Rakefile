require 'rubygems'
require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'spec/rake/spectask'

require 'lib/git'

GEM = "export-dir"
GEM_VERSION = Git::ExportDir.version
AUTHORS = "Jason Noble", "Rahsun McAfee"
SUMMARY = "A gem that provides git export functionality for one or more directories in a Repo"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.authors = AUTHORS
  s.executables = ['git-exportdir']
  
  s.require_path = 'lib'
  s.autorequire = GEM
  s.files = %w(LICENSE README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
end

task :default => :spec

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{sudo gem install pkg/#{GEM}-#{GEM_VERSION}}
end

desc "create a gemspec file"
task :make_spec do
  system("./bin/git-exportdir --help > README && git changelog -a --no-limit > HISTORY")
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

namespace :gem do
  desc "validate the gem like github does"
  task :validate do
    require 'rubygems/specification'
    data = File.read("#{GEM}.gemspec")
    spec = nil

    if data !~ %r{!ruby/object:Gem::Specification}
      Thread.new { spec = eval("$SAFE = 3\n#{data}") }.join
    else
      spec = YAML.load(data)
    end

    puts spec
    puts spec.validate ? "OK" : "FAIL"
  end
end