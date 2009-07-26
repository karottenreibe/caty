
class Sif::BooleanConverter

    include Sif::Helpers

    def convert( value )
        case value
        when nil, 'true' then true
        when 'false' then false
        else
            e = Sif::OptionArgumentError.new
            e.expected = 'true or false'
            raise e
        end
    end
end

class Sif::StringConverter

    include Sif::Helpers

    def convert( value )
        case value
        when nil
            e = Sif::OptionArgumentError.new
            e.expected = 'a string'
            raise e
        else value
        end
    end
end

class Sif::IntegerConverter

    include Sif::Helpers

    def convert( value )
        case value
        when %r{^[0-9]+$} then value.to_i
        else
            e = Sif::OptionArgumentError.new
            e.expected = 'an integer'
            raise e
        end
    end
end

