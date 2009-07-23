
class Sif::NoSuchTaskError < ArgumentError
end

class Sif::OptionArgumentError < ArgumentError

    attr_accessor :expected, :option

    def message
        "Bad argument to option `#{self.option}'. Expected #{self.expected}."
    end

end

