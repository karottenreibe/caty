
#
# Used to map things to other tasks and resolve
# those mappings at runtime.
#
Sif::Indirection = Struct.new(:name, :target) do

    #
    # Follows the indirection until it reaches
    # an end point and returns that.
    #
    def resolve( task_hash )
        next_item = task_hash[self.target]

        if next_item.is_a?(Sif::Indirection)
            next_item.resolve(task_hash)
        else
            next_item
        end
    end

end

