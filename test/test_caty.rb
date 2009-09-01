require 'rubygems'
require 'bacon'
require 'facon'
require 'caty'

describe 'Caty' do

    DEFAULT_TESTER = mock('default')

    class CatyTest < Caty

        default :beer
        map 'lager' => :beer

        def beer arg = DEFAULT_TESTER
            arg.beer
        end

        def energy_drink
            party(42) # raises an argument error
        end

        protected

        def punch arg
            arg.punch
        end

        private

        def wine arg
            arg.wine
        end

        def party
        end

    end

    def suppress_output
        output = $stdout = StringIO.new
        yield
        return output.string
    ensure
        $stdout = STDOUT
    end

    it 'should pass arguments' do
        tester = mock('beer')
        tester.should.receive(:beer)
        CatyTest.start!(['beer', tester])
    end

    it 'should handle mappings' do
        tester = mock('lager')
        tester.should.receive(:beer)
        CatyTest.start!(['lager', tester])
    end

    it 'should handle default task invocation' do
        DEFAULT_TESTER.should.receive(:beer)
        CatyTest.start!([])
    end

    it 'should not invoke private or protected methods' do
        suppress_output do
            tester = mock('punch')
            tester.should.not.receive(:punch)
            CatyTest.start!(['punch', tester])

            tester = mock('wine')
            tester.should.not.receive(:wine)
            CatyTest.start!(['wine', tester])
        end.should.not.be.empty
    end

    it 'should catch task argument errors' do
        suppress_output do
            lambda {
                CatyTest.start!(%w{beer and lemonade})
            }.should.not.raise ArgumentError
        end.should.not.be.empty
    end

    it 'should not catch other argument errors' do
        suppress_output do
            lambda {
                CatyTest.start!(%w{energy_drink})
            }.should.raise ArgumentError
        end.should.be.empty
    end

    it 'should handle unknown tasks' do
        suppress_output do
            CatyTest.start!(%w{salad})
        end.should.not.be.empty
    end

end

