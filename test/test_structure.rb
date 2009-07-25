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
        tasks.length.should.be 4

        tasks['argtask'].should.not.be.nil
        tasks['argtask'].name.should.be 'task1'

        tasks['task2'].should.not.be.nil
        tasks['task2'].name.should.be 'task2'

        tasks['mappedtask'].should.not.be.nil
        tasks['mappedtask'].name.should.be 'mappedtask'
        tasks['mappedtask'].target.should.be 'task2'

        tasks[:default].should.not.be.nil
        tasks[:default].target.should.be 'task1'
        tasks[:default].name.should.be :default
    end

    it 'should have global options' do
        gopts = TestSif.global_options
        gopts.length.should.be 3

        gopts['integer'].should.not.be.nil
        gopts['boolean'].should.not.be.nil
        gopts['string'].should.not.be.nil
    end

    it 'should have local options' do
        opts = TestSif.tasks['task2'].options
        opts.should.not.be.nil
        opts.length.should.be 3

        opts[0].name.should.be 'stringoption'
        opts[1].name.should.be 'integeroption'
        opts[2].name.should.be 'booleanoption'
    end

end

