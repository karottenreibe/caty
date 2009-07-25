require 'bacon'
require 'sif'

class TestSif < Sif

    global_options 'booleanoption' => false, 'stringoption' => 'uiae',
        'integeroption' => 42

    map :default => 'task1'
    def task1
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

        tasks['task1'].should.not.be.nil
        tasks['task1'].name.should.be.equal 'task1'

        tasks['task2'].should.not.be.nil
        tasks['task2'].name.should.be.equal 'task2'

        tasks['mappedtask'].should.not.be.nil
        tasks['mappedtask'].target.should.be.equal 'task2'

        tasks[:default].should.not.be.nil
        tasks[:default].target.should.be.equal 'task1'
    end

    it 'should have global options' do
        gopts = TestSif.global_options
        gopts.length.should.be.equal 3
        gopts.sort! do |a,b|
            a.name <=> b.name
        end

        gopts[0].name.should.be.equal 'booleanoption'
        gopts[1].name.should.be.equal 'integeroption'
        gopts[2].name.should.be.equal 'stringoption'
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

