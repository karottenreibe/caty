
module Caty::HasDescription

    attr_accessor :description

    #
    # If a description was set for this task,
    # this will return the first line of that desciption.
    # Else nil will be returned.
    #
    def short_description
        if self.description.nil?
            nil
        else
            self.description[%r{^[^\n\r]*}]
        end
    end

end

