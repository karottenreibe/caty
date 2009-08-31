
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
    #
    # If the deduced argument type is boolean, not giving an argument
    # on the command line is interpreted as giving 'true' as the argument.
    # For all the other types, a MissingOptionArgumentError is thrown.
    #
    def initialize( name, default )
        @name       = name
        @converter  = nil

        Sif::Converter.types.each do |type,converter|
            if default == type
                @converter   = converter.new
                @default     = nil
                break
            elsif converter.allowed_defaults.any? { |klass| default.is_a?(klass) }
                @converter   = converter.new
                @default     = default
                break
            end
        end

        raise(
            ArgumentError,
            'Only boolean, string and integer values or :boolean, :integer, :string allowed.'
        ) if @converter.nil?
    end

    #
    # Tries to remove the option from the args.
    # Returns the value grepped for this option.
    #
    def grep!( args )
        rex   = %r{^#{self.prefix}#{@name}(?:=(.+))?$}
        index = args.index { |arg| rex =~ arg }

        if index.nil?
            @default
        else
            match = rex.match(args.delete_at(index))
            @converter.convert(match[1])
        end
    rescue Sif::OptionArgumentError  => e
        e.option = @name
        raise e
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

