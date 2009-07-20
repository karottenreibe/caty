
#
# Represents a single task.
# A Task object is created for every public method created
# in the Sif subclass.
#
class Sif::Task

    #
    # Creates a new task with the given name for the
    # given instance_method.
    #
    def initialize( name, instance_method, options )
    end

    #
    # Removes the task name from the args Array, if it is
    # present.
    # Tries to remove the options defined for this task
    # from the args Array.
    # Returns an OpenStruct containing the retrieved
    # options.
    #
    def parse!( args )
    end

    #
    # Executes the associated instance_method by binding it
    # to the given _context_.
    #
    def execute( context )
        @instance_method.bind(context).call(*@args)
    end

end

