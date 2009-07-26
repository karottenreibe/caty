
#
# Represents a single option.
# An Option object is created for every option
# specified via Sif#task_options().
# The sum of all options parsed is accessible
# via the Sif#options() method.
#
class Sif::Option

    include Sif::Helpers

    attr_reader :name

    #
    # Creates a new option with the given name and default value.
    #
    # default may be one of the following:
    # - :boolean
    #   nil is the default, any given argument will be coerced
    #   into a boolean value.
    # - :string
    #   nil is the default, any given argument will be coerced
    #   into a string value.
    # - :integer
    #   nil is the default, any given argument will be coerced
    #   into a integer value.
    # - a Integer, String or Boolean value
    #   the passed value is the default value, any given argument
    #   will be coerced into the given type.
    # - any other value will be treated as if a String had been
    #   given.
    #TODO lambdas
    #
    # If the deduced argument type is boolean, not giving an argument
    # is interpreted as giving true as the argument.
    # Else, a MissingOptionArgumentError is thrown.
    #
    def initialize name, default
        @name = name

        case default
        when :boolean
            @converter = Sif::BooleanConverter.new
            @default = nil
        when :integer
            @converter = Sif::IntegerConverter.new
            @default = nil
        when :string
            @converter = Sif::StringConverter.new
            @default = nil
        when true, false
            @converter = Sif::BooleanConverter.new
            @default = default
        when Integer
            @converter = Sif::IntegerConverter.new
            @default = default
        when String
            @converter = Sif::StringConverter.new
            @default = default
        else
            raise ArgumentError,
                'Only boolean, string and integer values or :boolean, :integer, :string allowed.'
        end
    end

    #
    # Tries to remove the option from the args.
    # Returns the value grepped for this option.
    #
    def grep! args
        rex = %r{^#{self.prefix}#{@name}(?:=(.+))?$}
        args.each do |arg|
            if rex =~ arg
                return @converter.convert($1)
            end
        end

        @default
    rescue Sif::OptionArgumentError  => err
        raise returning(err) do |e|
            e.option = @name
        end
    end

    def to_s
        "[#{self.prefix}#{@name}=#{
            @default.nil? ? '' : @default.inspect
        }]"
    end

    protected

    #
    # Defines the prefix of this option.
    # May be overwritten by subclasses.
    #
    def prefix
        '-'
    end

end

