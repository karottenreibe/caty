
require 'delegate'
require 'ohash'

class Sif::OptionArray < Array

    include Sif::Helpers

    def grep!( args )
        returning(OpenHash.new) do |hash|
            self.each do |option|
                hash[option.name] = option.grep!(args)
            end
        end
    end

end

