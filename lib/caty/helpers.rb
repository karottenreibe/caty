#
# Contains the Helpers module that will be
# mixed into a number of classes.
#

module Caty::Helpers

    private

    #
    # The K combinator.
    #
    def returning( value )
        yield value
        value
    end

end

