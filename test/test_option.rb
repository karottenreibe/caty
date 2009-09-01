require 'rubygems'
require 'bacon'
require 'facon'
require 'caty'

describe 'An Option' do

    it 'should return a default value' do
        args = %w{bar be cue sauce}

        %w{boolean string integer}.each do |type|
            o = Caty::Option.new('beer', type.to_sym)
            o.grep!(args).should.be.nil
            args.length.should.be.equal 4
        end

        [true, 'coke', 42].each do |default|
            o = Caty::Option.new('beer', default)
            o.grep!(args).should.be.equal default
            args.length.should.be.equal 4
        end
    end

    it 'should complain on bad default value type' do
        lambda {
            Caty::Option.new('beer', Object.new)
        }.should.raise ArgumentError
    end

    it 'should grep boolean values' do
        %w{-beer=true -beer -beer=1}.each do |option|
            args = [option]
            o = Caty::Option.new('beer', :boolean)
            o.grep!(args).should.be.true
            args.should.be.empty
        end

        %w{-beer=false -beer=0}.each do |option|
            args = [option]
            o = Caty::Option.new('beer', :boolean)
            o.grep!(args).should.be.false
            args.should.be.empty
        end

        lambda {
            o = Caty::Option.new('beer', :boolean)
            o.grep!(%w{-beer=shallow})
        }.should.raise Caty::OptionArgumentError
    end

    it 'should grep string values' do
        args = %w{-beer=fine}
        o = Caty::Option.new('beer', :string)
        o.grep!(args).should.be.equal 'fine'
        args.should.be.empty

        lambda {
            o = Caty::Option.new('beer', :string)
            o.grep!(%w{-beer})
        }.should.raise Caty::OptionArgumentError
    end

    it 'should grep integer values' do
        args = %w{-beer=42}
        o = Caty::Option.new('beer', :integer)
        o.grep!(args).should.be.equal 42
        args.should.be.empty

        args = %w{-beer=-23}
        o = Caty::Option.new('beer', :integer)
        o.grep!(args).should.be.equal -23
        args.should.be.empty

        lambda {
            o = Caty::Option.new('beer', :integer)
            o.grep!(%w{-beer})
        }.should.raise Caty::OptionArgumentError
    end

end

