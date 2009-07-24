
module Sif::Helpers

    private

    #
    # The K combinator.
    #
    def returning( value )
        yield value
        value
    end

end

