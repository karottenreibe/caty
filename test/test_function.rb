require 'rubygems'
require 'bacon'
require 'facon'
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

    class SifTest < Sif

        map :default => :beer,
            'lager' => :beer
        def beer arg
            arg.beer
        end

        protected

        def punch arg
            arg.punch
        end

        private

        def wine arg
            arg.wine
        end

    end

    def suppress_output
        $stdout = StringIO.new
        yield
    ensure
        $stdout = STDOUT
    end

    it 'should pass arguments' do
        tester = mock('beer')
        tester.should.receive(:beer)
        SifTest.start(['beer', tester])
    end

    it 'should handle mappings' do
        tester = mock('lager')
        tester.should.receive(:beer)
        SifTest.start(['lager', tester])
    end

    it 'should handle default task invocation' do
    end

    it 'should not invoke private or protected methods' do
        suppress_output do
            tester = mock('punch')
            tester.should.not.receive(:punch)
            SifTest.start(['punch', tester])

            tester = mock('wine')
            tester.should.not.receive(:wine)
            SifTest.start(['wine', tester])
        end
    end

end

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

    it 'let its options grep' do
        options = mock('options')
        options.should.receive(:grep!).with(%w{beer}).and_return(options)

        t = Sif::Task.new('brew_beer', nil, options)
        t.parse!(%w{beer}).should.equal options
    end

end

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

describe 'An Option' do

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
        lambda {
            Sif::Option.new('beer', Object.new)
        }.should.raise ArgumentError
    end

    it 'should grep boolean values' do
        %w{-beer=true -beer}.each do |option|
            o = Sif::Option.new('beer', :boolean)
            o.grep!([option]).should.be.true
        end

        o = Sif::Option.new('beer', :boolean)
        o.grep!(%w{-beer=false}).should.be.false

        lambda {
            o = Sif::Option.new('beer', :boolean)
            o.grep!(%w{-beer=shallow})
        }.should.raise Sif::OptionArgumentError
    end

    it 'should grep string values' do
        o = Sif::Option.new('beer', :string)
        o.grep!(%w{-beer=fine}).should.be.equal 'fine'

        lambda {
            o = Sif::Option.new('beer', :string)
            o.grep!(%w{-beer})
        }.should.raise Sif::OptionArgumentError
    end

    it 'should grep integer values' do
        o = Sif::Option.new('beer', :integer)
        o.grep!(%w{-beer=42}).should.be.equal 42

        o = Sif::Option.new('beer', :integer)
        o.grep!(%w{-beer=-23}).should.be.equal -23

        lambda {
            o = Sif::Option.new('beer', :integer)
            o.grep!(%w{-beer})
        }.should.raise Sif::OptionArgumentError
    end

end

