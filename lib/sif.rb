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

    #
    # Returns the options for the called task.
    #
    attr_accessor :task_options

    #
    # Returns the global options for this invocation.
    #
    attr_accessor :global_options

    class << self

        #
        # Starts commandline parsing.
        #
        #     Subclass.start arguments_array
        #     Subclass.start
        #
        # Returns 0 on success, a negative Integer when
        # an ArgumentError is detected.
        # 
        def start( args = ARGV )
            initialize_instance

            sif = self.new
            sif.global_options = @global_options.grep!(args)
            
            begin
                task_name = args.delete_at(0)
                execute(sif, task_name, args)
                return true
            rescue Sif::NoSuchTaskError, Sif::OptionArgumentError => e
                $stdout.puts e.message
                return false
            rescue ArgumentError => e
                # verify that this is actually the task throwing the error
                if is_task_argument_error(e.backtrace, task_name)
                    task = @tasks.find_task(task_name)
                    $stdout.puts "Bad arguments for task #{task.name}."
                    $stdout.puts "Usage: #{task.to_s}"
                    return false
                else
                    raise
                end
            end
        end

        #
        # Adds options for the following task.
        #
        #     task_options 'option_name' => default, 'option2' ...
        #
        def task_options( options_hash )
            initialize_instance

            options_hash.each do |name,default|
                @task_options << Sif::Option.new(name, default)
            end
        end

        #
        # Adds global options.
        # The first option will be decorated with the last description
        # defined via #desc().
        #
        #     global_options 'option_name' => default, 'option2' ...
        #
        def global_options( options_hash )
            initialize_instance

            options_hash.each do |name,default|
                option = Sif::GlobalOption.new(name, default)
                option.description = @description

                @global_options << option
                reset_decorators
            end
        end

        #
        # Creates aliases for tasks.
        #
        #     map 'alias' => :task_name
        #     map %w{alias1 alias2} => :task_name
        #     map :default => 'task_name'
        #
        def map( mapping_hash )
            initialize_instance

            mapping_hash.each do |mapping,target|
                @tasks[mapping] = Sif::Indirection.new(target.to_s)
            end
        end

        #
        # Decorates the next definition with a description.
        #
        def desc( usage, description )
            @description, @usage = description, usage
        end

        private

        #
        # Metaprogramming.
        # See Module#method_added
        # Creates a new task, if the method that was added was
        # public.
        #
        def method_added( meth )
            initialize_instance
            name = meth.to_s

            # only add public methods as tasks
            if self.public_instance_methods.include?(name)
                method = self.instance_method(name)
                task = Sif::Task.new(name, method, @task_options) if @tasks[name].nil?
                task.description = @description
                task.usage = @usage

                @tasks[name] = task
                reset_decorators
            end
        end

        #
        # Tests whether the given backtrace is from
        # a argument error in task invocation.
        #
        def is_task_argument_error( backtrace, task_name )
            backtrace[0].end_with?("in `#{task_name}'") and
            backtrace[1].end_with?("in `call'") and
            backtrace[2].end_with?("in `execute'") and
            backtrace[3].end_with?("in `execute'") and
            backtrace[4].end_with?("in `start'")
        end
        
        #
        # Resets the decorators applied via #desc(),
        # #usage() and #task_options().
        #
        def reset_decorators
            @task_options = OptionArray.new
            @description = nil
            @usage = nil
        end

        #
        # Initializes the tasks, options and global options
        # storage instance variables.
        #
        def initialize_instance
            @task_options ||= Sif::OptionArray.new
            @global_options ||= Sif::OptionArray.new
            @tasks ||= Sif::TaskHash.new
        end

        #
        # Does the actual work of executing the task for #start().
        #
        def execute( sif, task_name, args )
            if task_name.nil?
                task = @tasks.find_task(:default)
            else
                task = @tasks.find_task(task_name)
            end

            case task
            when nil
                raise Sif::NoSuchTaskError, "There is no task named `#{task_name}'"
            else
                sif.task_options = task.parse!(args)
                task.execute(sif)
            end
        end

    end

end

require 'sif/help_system'
Sif.extend(Sif::HelpSystem)

require 'sif/helpers'
require 'sif/errors'
require 'sif/has_description'
require 'sif/task_hash'
require 'sif/option_array'
require 'sif/task'
require 'sif/option'
require 'sif/converters'
require 'sif/global_option'
require 'sif/indirection'

