require 'rubygems'
require 'bacon'
require 'facon'
require 'sif'

describe 'An OptionArray' do

    it 'should grep' do
        a = Sif::OptionArray.new
        mock1 = mock('beer', :name => 'beer')
        mock2 = mock('rootbeer', :name => 'rootbeer')

        mock1.should.receive(:grep!).with([]).and_return(42)
        mock2.should.receive(:grep!).with([]).and_return(23)

        a << mock1
        a << mock2

        opts = a.grep!([])
        opts.beer.should.equal 42
        opts.rootbeer.should.equal 23
    end

end

