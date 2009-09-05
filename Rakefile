require 'rake/clean'

CLEAN.include '_site'

task :deploy => [:clean] do
    sh 'jekyll --server'
end

task :test => [:clean] do
    sh 'jekyll --server'
end

