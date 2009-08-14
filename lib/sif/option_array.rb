
require 'delegate'
require 'ohash'

class Sif::OptionArray < Array

    include Sif::Helpers

    def grep!( args )
        returning(OpenHash.new) do |hash|
            self.each do |option|
                grab = option.grep!(args)
                hash[option.name.to_sym] = grab unless grab.nil?
            end
        end
    end

end

