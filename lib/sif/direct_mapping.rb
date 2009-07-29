
#
# Maps special tasks directly to an instance method, ignoring
# visibility.
#
class Sif::DirectMapping

    def initialize( method )
        @method = method
    end

    def execute( context )
        context.send(@method)
    end

end

