require 'rubygems'
require 'bacon'
require 'facon'
require 'sif'

describe 'A Task' do

    it 'should call its associated method and pass the arguments' do
        context = mock('context')
        meth = mock('method')
        meth.should.receive(:call).with('beer')
        meth.should.receive(:bind).with(context).and_return(meth)

        t = Sif::Task.new('brew_beer', meth, mock('options', :grep! => nil))
        t.parse!(%w{beer})
        t.execute(context)
    end

    it 'should let its options grep' do
        options = mock('options')
        options.should.receive(:grep!).with(%w{beer}).and_return(options)

        t = Sif::Task.new('brew_beer', nil, options)
        t.parse!(%w{beer}).should.equal options
    end

end

