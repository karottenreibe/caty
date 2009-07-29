# -*- ruby -*-

require 'rubygems'
require 'hoe'

module Rake
    def self.remove_task(task_name)
        Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
    end
end

Hoe.spec('sif') do |p|
    p.version = '0.0.1'
    p.developer('Fabian Streitel', 'karottenreibe@gmail.com')
    p.remote_rdoc_dir = 'rdoc'
end

task :manifest do
    sh 'rake check_manifest | grep -v "(in " | patch'
    sh 'vim Manifest.txt'
end

Rake.remove_task :test
task :test do 
    sh 'bacon -Ilib test/*'
end

# vim: syntax=ruby
