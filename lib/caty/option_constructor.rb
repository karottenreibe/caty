
#
# Constructs options using a DSL, e.g:
#
#   constructor.construct do
#        desc('description')
#        string  :option, 'default'
#
#        desc('desc2')
#        integer :nother_one
#   end
#
class Caty::OptionConstructor

    class << self

        #
        # Returns an array of all the option types
        # registered.
        #
        def types
            @types ||= Array.new
        end

        #
        # Registers an option type (symbol) with the
        # constructor.
        #
        def register( type )
            @types ||= Array.new
            @types <<  type
        end

    end

    #
    # Create a new OptionConstructor that constructs
    # the given options of the given class.
    #
    def initialize( option_klass )
        @klass     = option_klass
        @options   = Array.new
    end

    #
    # Constructs the actual options according to the
    # given block.
    #
    def construct( &block )
        self.instance_eval(&block)
        @options
    end

    private

    #
    # Emulates the type methods, e.g:
    #   string :name, 'default'
    #
    def method_missing( meth, *args, &block )
        if self.class.types.include?(meth) and args.length.between?(1,2)
            name    = args[0]
            default = args.length == 2 ?
                args[1] : meth
            option = @klass.new(name, default)
            option.description, @description =
                @description, nil
            @options << option
        else
            super
        end
    end

    #
    # Allows you to describe the constructed options.
    #
    def desc( description )
        @description = description
    end

end

