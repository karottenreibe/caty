
#
# Represents a single global option.
# A GlobalOption object is created for every option
# specified via Odin#global_options().
# The sum of all global options parsed is accessible
# via the Odin#global_options() method.
#
class GlobalOption < Option

    #
    # Creates a new global option that reacts to the given
    # name and has the given default value.
    # 
    # If the name is 'foo', the option will react to
    # '-foo'.
    #
    def initialize name, default
    end

end

