
#
# Represents a single option.
# An Option object is created for every option
# specified via Odin#task_options().
# The sum of all options parsed is accessible
# via the Odin#options() method.
#
class Option

    #
    # Creates a new option that reacts to the given
    # name and has the given default value.
    # 
    # If the name is 'foo', the option will react to
    # '-foo'.
    #
    def initialize name, default
    end

    #
    # Tries to remove the option from the args.
    # Returns the value grepped for this option.
    #
    def grep! args
    end

end

