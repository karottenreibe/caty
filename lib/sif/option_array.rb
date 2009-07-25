
require 'delegate'
require 'ostruct'

class Sif::OptionArray < Array

    include Sif::Helpers

    def grep!( args )
        hash = returning(Hash.new) do |hash|
            self.each do |option|
                hash[option.name] = option.grep!(args)
            end
        end

        OpenStruct.new(hash)
    end

end

