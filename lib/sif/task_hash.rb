require 'delegate'

#
# A hash that preserves the order of insertion.
#
class Sif::TaskHash < SimpleDelegator

    #
    # Works like Hash#initialize.
    #
    def initialize( *args )
        @ary = Array.new
        @hash = Hash.new(*args)
        self.__setobj__(@hash)
    end

    #
    # Works like Hash#[].
    #
    def []( num_or_key )
        case num_or_key
        when Numeric, Range then @ary[num_or_key]
        else @hash[num_or_key]
        end
    end

    #
    # Works like Hash#[]=.
    #
    def []=( key, value )
        index = @ary.find { |item| item == @hash[key] }

        if @hash[key].nil? or index.nil?
            @ary << value
        else
            @ary[index] = value
        end

        @hash[key] = value
    end

    #
    # Follows indirections until the task behind
    # the given task name is discovered.
    #
    def find_task( task_name )
        task = self[task_name]

        case task
        when Sif::Indirection then self.find_task(task.target)
        else task
        end
    end

    #
    # Returns a copy of the task hash as an array.
    # The order of the items in the array is the same as in the
    # task hash.
    #
    def to_a
        @ary.dup
    end

    #
    # Returns a copy of the task hash as a plain hash.
    #
    def to_h
        @hash.dup
    end

end

