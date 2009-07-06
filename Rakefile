# -*- ruby -*-

require 'rubygems'
require 'hoe'

Hoe.spec('sif') do |p|
    p.version = '0.0.1'
    p.developer('Fabian Streitel', 'karottenreibe@gmail.com')
    p.remote_rdoc_dir = 'rdoc'
end

task :manifest do
    sh 'rake check_manifest | grep -v "(in " | patch'
    sh 'vim Manifest.txt'
end

# vim: syntax=ruby
