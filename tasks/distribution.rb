require 'yard'
require 'jeweler'

desc 'Generate documentation'
YARD::Rake::YardocTask.new

task :rdoc => :yardoc

Jeweler::Tasks.new do |gem|
  gem.name      = "realtimebattle"
  gem.summary   = "RealTimeBattle Ruby"
  gem.homepage  = "http://github.com/langalex/realtimebattle_rb"
  gem.author    = "Alex Lang, Lukas Rieder, Pat Allan"
  gem.email     = ""
  
  gem.files     = FileList[
    'lib/**/*.rb',
    'Rakefile',
    'tasks',
    'VERSION.yml'
  ]
  gem.test_files = FileList['spec/**/*.rb']
  gem.add_dependency 'sinatra'
  gem.add_dependency 'json'
end
