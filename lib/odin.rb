#
# This a mean rip-off of the great, one-and-only Thor.
# Kudos to Yehuda Katz.
#

#
# Handles commandline parsing.
#
# Subclass this and add public methods.
# These methods will become tasks, which will be
# callable via
#
#     app method_name
#
# Use the #global_options() and #task_options()
# methods to add global or task-specific options.
#
# Use the #map() method to create aliases for
# commands.
#
class Odin

    class << self

        #
        # Starts commandline parsing.
        #
        #     Subclass.start arguments_array
        #     Subclass.start
        #
        def start args = ARGV
        end

        #
        # Adds options for the current task.
        #
        #     task_options 'option_name', 'option2', ...
        #
        def task_options options_hash
        end

        #
        # Adds global options.
        #
        #     global_options 'option_name', 'option2', ...
        #
        def global_options options_hash
        end

        #
        # Creates aliases for tasks.
        #
        #     map 'alias' => :task_name
        #     map %w{alias1 alias2} => :task_name
        #
        def map mapping_hash
        end

    end

    #
    # Returns the options for the called task.
    #
    def options
    end

    #
    # Returns the global options for this invocation.
    #
    def global_options
    end

    #
    # Displays the auto-generated help for all tasks,
    # options and global options known to Odin.
    #
    def odin_help command = nil
    end

end

