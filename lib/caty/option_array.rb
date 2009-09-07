#
# Contains the OptionArray class.
#

require 'delegate'
require 'ohash'

#
# Represents an array of options and adds some
# useful methods.
#
class Caty::OptionArray < Array

    include Caty::Helpers

    #
    # Forwards the ::grep!() to the different Options
    # and collects the results into an OpenHash.
    #
    def grep!( args )
        returning(OpenHash.new) do |hash|
            self.each do |option|
                grab = option.grep!(args)
                hash[option.name.to_sym] = grab unless grab.nil?
            end
        end
    end

end

