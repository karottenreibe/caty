
require 'delegate'
require 'ohash'

class Sif::OptionArray < Array

    include Sif::Helpers

    def grep!( args )
        hash = returning(Hash.new) do |hash|
            self.each do |option|
                hash[option.name] = option.grep!(args)
            end
        end

        OpenHash.new(hash)
    end

end

