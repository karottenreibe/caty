require 'jeweler'

task :release do
    sh "vim HISTORY.markdown"
    sh "vim README.markdown"
    sh "git commit -a -m 'prerelease adjustments'; true"
end

Jeweler::Tasks.new do |gem|
    gem.name = 'caty'
    gem.summary = gem.description =
        'Caty is a command line parser that maps arguments to instance methods'
    gem.email = 'karottenreibe@gmail.com'
    gem.homepage = 'http://karottenreibe.github.com/caty'
    gem.authors = ['Fabian Streitel']
    gem.rubyforge_project = 'k-gems'
    gem.add_dependency('ohash')
end

Jeweler::RubyforgeTasks.new

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'Caty'
  rdoc.rdoc_files.include('lib/*.rb')
  rdoc.rdoc_files.include('lib/*/*.rb')
end

task :test do
    sh 'bacon -Ilib test/test_*.rb'
end

