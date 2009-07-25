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

    it 'should' do
    end

    it 'should' do
    end

end

describe 'Task' do

    it 'should' do
    end

end

describe 'Option' do

    it 'should' do
    end

end

