require 'delegate'

#
# A hash that preserves the order of insertion.
#
class Sif::OrderedHash < SimpleDelegator

    def initialize
        @ary = Array.new
        @hash = Hash.new
        self.__setobj__(@hash)
    end

    def each
        @ary.each do |item|
            yield(item.name, item)
        end
    end

    def []( num_or_key )
        case num_or_key
        when Numeric, Range then @ary[num_or_key]
        else @hash[num_or_key]
        end
    end

    def []=( key, value )
        index = @ary.find { |item| item == @hash[key] }

        if @hash[key].nil? or index.nil?
            @ary << value
        else
            @ary[index] = value
        end

        @hash[key] = value
    end

end

