
#
# Represents a single option.
# An Option object is created for every option
# specified via Sif#task_options().
# The sum of all options parsed is accessible
# via the Sif#options() method.
#
Sif::Option = Struct.new(:name, :default, :description) do

    #
    # Tries to remove the option from the args.
    # Returns the value grepped for this option.
    #
    def grep! args
    end

    private

    def prefix
        '-'
    end

end

