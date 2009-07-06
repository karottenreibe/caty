
#
# Represents a single task.
# A Task object is created for every public method created
# in the Odin subclass.
#
class Odin::Task

    #
    # Creates a new task with the given name for the
    # given instance_method.
    # The instance_method has to be bound to an object.
    #
    def initialize name, instance_method, options
    end

    #
    # Removes the task name from the args Array, if it is
    # present.
    # Tries to remove the options defined for this task
    # from the args Array.
    # Returns an OpenStruct containing the retrieved
    # options.
    #
    def parse! args
    end

end

