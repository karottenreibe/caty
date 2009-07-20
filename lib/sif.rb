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
# Use the ::start() method to start parsing.
#
class Sif

    class << self

        #
        # Starts commandline parsing.
        #
        #     Subclass.start arguments_array
        #     Subclass.start
        #
        def start( args = ARGV )
            sif = self.new
            sif.global_options = @global_options.grep!(args)
            
            task_name = args.delete_at(0)
            task = @tasks[task_name] || @tasks[:default]

            if task.nil?
                raise Sif::NoSuchTaskError.new("There is no task named `#{task_name}'")
            else
                sif.options = task.parse!(args)
                task.execute(sif)
            end
        end

        #
        # Adds options for the current task.
        #
        #     task_options 'option_name' => default, 'option2' ...
        #
        def task_options( options_hash )
            @task_options ||= Array.new
            options_hash.each do |name,default|
                @task_options << Sif::Option.new(name, default)
            end
        end

        #
        # Adds global options.
        #
        #     global_options 'option_name' => default, 'option2', ...
        #
        def global_options( options_hash )
            @global_options ||= Array.new
            options_hash.each do |name,default|
                @global_options << Sif::GlobalOption.new(name, default)
            end
        end

        #
        # Creates aliases for tasks.
        #
        #     map 'alias' => :task_name
        #     map %w{alias1 alias2} => :task_name
        #     map :default => :task_name
        #
        def map( mapping_hash )
            @tasks ||= Sif::OrderedHash.new
            mapping_hash.each do |mapping,target|
                @tasks[mapping] = Sif::Indirection.new(target)
            end
        end

        #
        # Metaprogramming.
        # See Module#method_added
        # Creates a new task, if the method that was added was
        # public.
        #
        def method_added meth
            name = meth.to_s

            # only add public methods as tasks
            if self.public_instance_methods.include?(name)
                method = self.public_instance_method(name)
                @tasks[name] = Sif::Task.new(name, method, @task_options) if @tasks[name].nil?
                @task_options = Array.new
            end
        end

    end

    #
    # Returns the options for the called task.
    #
    attr_accessor :options

    #
    # Returns the global options for this invocation.
    #
    attr_accessor :global_options

    #
    # Displays the auto-generated help for all tasks,
    # options and global options known to Sif.
    #
    def sif_help( command = nil )
        #TODO
    end

end

class Sif::NoSuchTaskError < ArgumentError; end

require 'sif/ordered_hash'
require 'sif/task'
require 'sif/option'
require 'sif/global_option'
require 'sif/indirection'

