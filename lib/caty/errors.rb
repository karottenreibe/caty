#
# Contains error classes used by Caty.
#

class Caty::NoSuchTaskError < ArgumentError
end

class Caty::OptionArgumentError < ArgumentError

    attr_accessor :expected, :option

    def message
        "Bad argument to option `#{self.option}'. Expected #{self.expected}."
    end

end

