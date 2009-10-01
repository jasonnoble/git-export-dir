# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{export-dir}
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jason Noble", "Rahsun McAfee"]
  s.autorequire = %q{export-dir}
  s.date = %q{2009-10-01}
  s.default_executable = %q{git-exportdir}
  s.description = %q{A gem that provides git export functionality for one or more directories in a Repo}
  s.executables = ["git-exportdir"]
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["LICENSE", "README", "Rakefile", "bin/git-exportdir", "lib/git.rb", "spec/git_export_dir_spec.rb", "spec/spec_helper.rb"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A gem that provides git export functionality for one or more directories in a Repo}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
