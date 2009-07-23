
#
# Represents a single global option.
# A GlobalOption object is created for every option
# specified via Sif::global_options().
# The sum of all global options parsed is accessible
# via the Sif#global_options() method.
#
class Sif::GlobalOption < Sif::Option

    include Sif::HasDescription

    private

    def prefix
        '--'
    end

end

