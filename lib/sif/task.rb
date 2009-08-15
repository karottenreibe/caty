
#
# Represents a single task.
# A Task object is created for every public method created
# in the Sif subclass.
#
class Sif::Task

    include Sif::Helpers
    include Sif::HasDescription
    include Sif::Resolvable

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
    # Returns an OpenHash containing the retrieved
    # options.
    #
    def parse!( args )
        @args = args
        @options.grep!(args)
    end

    #
    # Executes the associated instance_method by binding it
    # to the given _context_.
    #
    def execute( context )
        @instance_method.bind(context).call(*@args)
    end

    #
    # Returns an array of the string representation of the task and its
    # options to be used by the help system.
    #
    def to_help
        [ self.to_s , self.short_description, self.description ]
    end

    def to_s
        returning(@name) do |output|
            output << " #{@usage}" unless @usage.nil?

            @options.each do |option|
                output << " #{option}"
            end
        end
    end

end

