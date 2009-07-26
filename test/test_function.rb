require 'bacon'
require 'sif'

class TestSif < Sif

    global_options 'booleanoption' => false, 'stringoption' => 'uiae',
        'integeroption' => 42

    task_options 'stringoption' => :string, 'integeroption' => :integer,
        'booleanoption' => :boolean
    map 'mappedtask' => :task1
    map :default => 'task1'
    def task1 *args
        TestSif.args = args
        TestSif.opts = opts
        TestSif.gopts = gopts
    end

    class << self
        attr_accessor :args, :opts, :gopts
    end

end

describe 'Sif' do

    it 'should pass arguments' do
    end

    it 'should handle mappings' do
    end

    it 'should handle default task invocation' do
    end

end

describe 'Task' do

    it 'should grep the task name' do
    end

end

describe 'Option' do

    it 'should return a default value' do
        args = %w{bar be cue sauce}

        %w{boolean string integer}.each do |type|
            o = Sif::Option.new('beer', type.to_sym)
            o.grep!(args).should.be.nil
            args.length.should.be.equal 4
        end

        [true, 'coke', 42].each do |default|
            o = Sif::Option.new('beer', default)
            o.grep!(args).should.be.equal default
            args.length.should.be.equal 4
        end
    end

    it 'should complain on bad default value type' do
        lambda { Sif::Option.new('beer', Object.new) }.should.raise ArgumentError
    end

    it 'should grep boolean values' do
    end

    it 'should grep string values' do
    end

    it 'should grep integer values' do
    end

end

