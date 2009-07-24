
class Sif::BooleanConverter

    include Sif::Helpers

    def convert( value )
        case value
        when nil, 'true' then true
        when 'false' then false
        else
            raise returning(Sif::OptionArgumentError.new) do |e|
                e.expected = 'true or false'
            end
        end
    end
end

class Sif::StringConverter

    include Sif::Helpers

    def convert( value )
        case value
        when nil
            raise returning(Sif::OptionArgumentError.new) do |e|
                e.expected = 'a string'
            end
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
            raise returning(Sif::OptionArgumentError.new) do |e|
                e.expected = 'an integer'
            end
        end
    end
end

