
#
# Represents a single task.
# A Task object is created for every public method created
# in the Sif subclass.
#
class Sif::Task

    include Sif::HasDescription

    attr_accessor :name, :usage

    #
    # Creates a new task with the given name for the
    # given instance_method.
    #
    def initialize( name, instance_method, options )
        @name, @instance_method, @options =
            name, instance_method, options
    end

    #
    # Tries to remove the options defined for this task
    # from the args Array.
    # Returns an OpenStruct containing the retrieved
    # options.
    #
    def parse!( args )
        returning(Hash.new) do |options|
            @options.each do |option|
                options[option.name] = option.grep!
            end

            @args = args
        end
    end

    #
    # Executes the associated instance_method by binding it
    # to the given _context_.
    #
    def execute( context )
        @instance_method.bind(context).call(*@args)
    end

end

