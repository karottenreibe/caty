require 'bacon'
require 'sif'

class TestSif < Sif

    global_options 'booleanoption' => false, 'stringoption' => 'uiae',
        'integeroption' => 42

    map :default => 'argtask'
    def task1 arg
    end

    map 'mappedtask' => :task2
    task_options 'stringoption' => :string, 'integeroption' => :integer,
        'booleanoption' => :boolean
    def task2
    end

    class << self
        attr_accessor :tasks, :global_options
    end

end

describe 'Sif' do

    it 'should have tasks and mappings' do
        tasks = TestSif.tasks
        tasks.length.should.be.equal 4

        tasks['argtask'].should.not.be.nil
        tasks['argtask'].name.should.be.equal 'task1'

        tasks['task2'].should.not.be.nil
        tasks['task2'].name.should.be.equal 'task2'

        tasks['mappedtask'].should.not.be.nil
        tasks['mappedtask'].name.should.be.equal 'mappedtask'
        tasks['mappedtask'].target.should.be.equal 'task2'

        tasks[:default].should.not.be.nil
        tasks[:default].target.should.be.equal 'task1'
        tasks[:default].name.should.be.equal :default
    end

    it 'should have global options' do
        gopts = TestSif.global_options
        gopts.length.should.be.equal 3

        gopts['integer'].should.not.be.nil
        gopts['boolean'].should.not.be.nil
        gopts['string'].should.not.be.nil
    end

    it 'should have local options' do
        opts = TestSif.tasks['task2'].instance_variable_get(:@options)
        opts.should.not.be.nil
        opts.length.should.be.equal 3
        opts.sort! do |a,b|
            a.name <=> b.name
        end

        opts[0].name.should.be.equal 'booleanoption'
        opts[1].name.should.be.equal 'integeroption'
        opts[2].name.should.be.equal 'stringoption'
    end

end

