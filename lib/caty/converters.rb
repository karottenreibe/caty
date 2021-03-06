#
# Contains all the option converters.
#

#
# Base class for all option converters.
# Offers some metaprogramming.
#
class Caty::Converter

    include Caty::Helpers

    class << self

        attr_accessor :allowed_defaults

        #
        # Registers a converter subclass for a type (symbol)
        # and some default value classes
        #
        def type( type, *allowed_defaults )
            @@types ||= Hash.new
            @@types[type]     = self
            Caty::OptionConstructor.register(type)
            @allowed_defaults = allowed_defaults
        end

        #
        # Returns a hash containing
        #   :type => Class
        # for all converter subclasses
        #
        def types
            @@types ||= Hash.new
        end

    end

end

#
# Converter for boolean values:
#   %w(true false 1 0) << nil
#
class Caty::BooleanConverter < Caty::Converter

    type(:boolean, TrueClass, FalseClass)

    def convert( value )
        case value
        when 'true',  '1', nil then true
        when 'false', '0'      then false
        else
            e = Caty::OptionArgumentError.new
            e.expected = '0, 1, true, false or no argument'
            raise e
        end
    end

end

#
# Converter for string values:
#   /.*/
#
class Caty::StringConverter < Caty::Converter

    type(:string, String)

    def convert( value )
        case value
        when nil
            e = Caty::OptionArgumentError.new
            e.expected = 'a string'
            raise e
        else value
        end
    end

end

#
# Converter for integer values:
#   /^[+-]?[0-9]+$/
#
class Caty::IntegerConverter < Caty::Converter

    type(:integer, Fixnum)

    def convert( value )
        case value
        when %r{^[+-]?[0-9]+$} then value.to_i
        else
            e = Caty::OptionArgumentError.new
            e.expected = 'an integer'
            raise e
        end
    end

end

