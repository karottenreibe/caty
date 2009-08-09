
require 'delegate'
require 'ohash'

class Sif::OptionArray < Array

    include Sif::Helpers

    def grep!( args )
        returning(OpenHash.new) do |hash|
            self.each do |option|
                hash[option.name.to_sym] = option.grep!(args)
            end
        end
    end

end

