require 'rake/clean'

CLEAN.include '_site'

task :deploy => [:clean] do
    sh 'jekyll --server'
end

task :test => [:clean] do
    sh 'jekyll --server 4567'
end

task :rdoc do
    sh 'git checkout master'
    sh 'rake rdoc'
    sh 'mv rdoc __rdoc'
    sh 'git checkout gh-pages'
    sh 'mv __rdoc rdoc'
    sh 'git add rdoc'
    sh 'git commit -a -m "updated rdoc"'
end

