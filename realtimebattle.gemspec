# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{realtimebattle}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alex Lang, Lukas Rieder, Pat Allan"]
  s.date = %q{2009-10-03}
  s.email = %q{}
  s.files = [
    "Rakefile",
     "VERSION.yml",
     "lib/arena.rb",
     "lib/bot.rb",
     "lib/bullet.rb",
     "lib/geometry_helper.rb",
     "lib/object_info.rb"
  ]
  s.homepage = %q{http://github.com/langalex/realtimebattle_rb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{RealTimeBattle Ruby}
  s.test_files = [
    "spec/arena_spec.rb",
     "spec/bot_spec.rb",
     "spec/bullet_spec.rb",
     "spec/integration_spec.rb",
     "spec/object_info_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
