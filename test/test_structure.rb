require 'bacon'
require 'sif'

class TestSif < Sif

    global_options do
        boolean 'booleanoption', false
        string  'stringoption',  'uiae'
        integer 'integeroption',  42
    end

    default :task1

    def task1
    end

    map 'mappedtask' => :task2
    task_options 'stringoption'  => :string,
                 'integeroption' => :integer,
                 'booleanoption' => :boolean
    def task2
    end

    class << self
        attr_accessor :tasks, :global_options, :default
    end

end

describe 'Sif' do

    it 'should have tasks and mappings' do
        tasks = TestSif.tasks
        tasks.length.should.be.equal 3

        tasks[:task1].should.not.be.nil
        tasks[:task1].name.should.be.equal :task1

        tasks[:task2].should.not.be.nil
        tasks[:task2].name.should.be.equal :task2

        tasks[:mappedtask].should.not.be.nil
        tasks[:mappedtask].target.should.be.equal :task2

        TestSif.default.should.be.equal :task1
    end

    it 'should have global options' do
        gopts = TestSif.global_options
        gopts.length.should.be.equal 3
        gopts.sort_by(&:name)

        gopts[0].name.should.be.equal 'booleanoption'
        gopts[1].name.should.be.equal 'stringoption'
        gopts[2].name.should.be.equal 'integeroption'
    end

    it 'should have task options' do
        opts = TestSif.tasks[:task2].instance_variable_get(:@options)
        opts.should.not.be.nil
        opts.length.should.be.equal 3
        opts.sort! do |a,b|
            a.name.to_s <=> b.name.to_s
        end

        opts[0].name.should.be.equal :booleanoption
        opts[1].name.should.be.equal :integeroption
        opts[2].name.should.be.equal :stringoption
    end

end

