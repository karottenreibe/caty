#
# Contains the GlobalOption class.
#

#
# Represents a single global option.
#
# A GlobalOption object is created for every option
# specified via Caty::global_options().
# The sum of all global options parsed is accessible
# via the Caty#global_options() method.
#
class Caty::GlobalOption < Caty::Option

    include Caty::HasDescription

    #
    # Returns a string representation to be used by
    # the help system.
    #
    def to_help
        [ self.to_s, self.short_description, self.description ]
    end

    def to_s( ljust = 0 )
        returning('') do |str|
            str << "#{self.prefix}#{@name}=#{
                @default.nil? ? '' : @default.inspect
            }".ljust(ljust)
        end
    end

    protected

    def prefix
        '--'
    end

end

