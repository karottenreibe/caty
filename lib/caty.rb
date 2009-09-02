#
# This a mean rip-off of the great, one-and-only Thor.
# Kudos to Yehuda Katz.
#
# http://yehudakatz.com/2008/05/12/by-thors-hammer/
#

#
# Handles command line parsing.
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
# tasks.
#
# Use the ::start!() method to start parsing.
#
class Caty

    #
    # Returns the options for the called task as
    # an OpenHash.
    #
    attr_accessor :task_options

    #
    # Returns the global options for this invocation as
    # a OpenHash.
    #
    attr_accessor :global_options

    class << self

        #
        # Starts command line parsing.
        #
        #     Subclass.start! arguments_array
        #     Subclass.start!
        #
        # Returns 0 on success, a negative Integer when
        # an ArgumentError is detected.
        # 
        def start!( args = ARGV )
            initialize_instance

            begin
                caty = self.new
                caty.global_options = @global_options.grep!(args)

                task_name = args.delete_at(0) || @default
                raise Caty::NoSuchTaskError, "You need to provide a task" if task_name.nil?

                task = @tasks.resolve(task_name.to_sym)

                if task.nil?
                    raise Caty::NoSuchTaskError, "There is no task named `#{task_name}'"
                else
                    caty.task_options = task.parse!(args)

                    caty.instance_eval(@before) unless @before.nil?
                    task.execute(caty)
                    caty.instance_eval(@after) unless @after.nil?
                end

                return true

            rescue Caty::NoSuchTaskError, Caty::OptionArgumentError => e
                $stdout.puts e.message
                return false

            rescue ArgumentError => e
                # verify that this is actually the task throwing the error
                if is_task_argument_error(e.backtrace, task_name)
                    $stdout.puts "Bad arguments for task #{task.name}."
                    $stdout.puts "Usage: #{task.to_s}"
                    return false
                else
                    raise
                end
            end
        end

        #
        # Simply class_evals the given block on
        # your Caty subtype, thus allowing you to
        # add new tasks in different source files.
        #
        #     class X < Caty
        #     end
        #
        #     X.append do
        #         def bar
        #             puts 'bar task'
        #         end
        #     end
        #
        #     X.start!(%w{bar})
        #
        def append( &block )
            self.class_eval(&block)
        end

        #
        # Methods to be used by the inheriting class.
        #
        private

        #
        # Can be used to cut off whitespace in front of
        # #desc() descriptions, so it can be written more
        # nicely in the source.
        #
        # Describing this method accurately is terribly complicated,
        # so here's an example:
        #
        #   cut("
        #       first
        #         second
        #       third
        #   ")
        #
        # produces the string
        #
        #   "first\n  second\nthird"
        #
        # Notice the preserved whitespace in front of
        # 'second'!
        #
        def cut( description )
            description.sub!(%r{\A\n+}, '')
            description =~ %r{\A([ \t]*)}

            unless $1.nil?
                space = $1
                description.gsub!(%r{^#{space}}, '')
            end

            description.gsub(%r{\n\Z}, '')
        end

        #
        # Adds options for the following task.
        #
        #     task_options :option_name => default, :option2 ...
        #
        def task_options( options_hash )
            initialize_instance
            options_hash.each do |name,default|
                @task_options << Caty::Option.new(name.to_sym, default)
            end
        end

        #
        # Adds global options.
        # The first option will be decorated with the last description
        # defined via #desc().
        #
        #     global_options do
        #         desc('description')
        #         string  'option_name' => 'default'
        #
        #         desc('desc2')
        #         integer 'option2'
        #     end
        #
        def global_options( &block )
            initialize_instance
            constructor = Caty::OptionConstructor.new(Caty::GlobalOption)
            @global_options.concat(constructor.construct(&block))
        end

        #
        # Creates aliases for tasks.
        #
        #     map :alias            => :task_name
        #     map %w{alias1 alias2} => :task_name
        #
        def map( mapping_hash )
            initialize_instance

            mapping_hash.each do |mappings,target|
                mappings = [mappings] unless mappings.is_a?(Array)

                mappings.each do |mapping|
                    @tasks[mapping.to_sym] = Caty::Indirection.new(mapping.to_sym, target.to_sym)
                end
            end
        end

        #
        # Defines a block of code that will be executed right
        # before any task is called.
        # _self_ will point to the Caty instance.
        #
        #     before do
        #         puts self.inspect
        #     end
        #
        def before( &block )
            @before = block
        end

        #
        # Defines a default task.
        #
        #     default :task
        #
        def default( task )
            @default = task.to_sym
        end

        #
        # Defines a block of code that will be executed right
        # after any task is called.
        # _self_ will point to the Caty instance.
        #
        # NOTE: this code will not be executed if an error occured.
        #
        #     after do
        #         puts self.inspect
        #     end
        #
        def after( &block )
            @after = block
        end

        #
        # Decorates the next definition with a description and
        # optionally a usage string.
        #
        #     desc 'usage info', 'long description'
        #     desc 'long description'
        #
        def desc( usage, description = nil )
            if description.nil?
                @description = usage
            else
                @description, @usage = description, usage
            end
        end

        #
        # Methods to be used by Caty itself.
        #
        protected

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
                task = @tasks[meth] || Caty::Task.new(meth, method, @task_options)
                task.description = @description
                task.usage = @usage

                @tasks[meth] = task
                reset_decorators
            end
        end

        #
        # Tests whether the given backtrace is from
        # a argument error in task invocation.
        #
        def is_task_argument_error( backtrace, task_name )
            backtrace[0].end_with?("in `#{task_name}'") and  # inside the task method
            backtrace[1].end_with?("in `call'")         and  # in Task#call
            backtrace[2].end_with?("in `execute'")      and  # in Task#execute
            backtrace[3].end_with?("in `start!'")            # in Caty::start!
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
            @task_options ||= Caty::OptionArray.new
            @global_options ||= Caty::OptionArray.new
            @tasks ||= Caty::TaskHash.new
        end

    end

end

require 'caty/help_system'
Caty.extend(Caty::HelpSystem)

require 'caty/helpers'
require 'caty/errors'
require 'caty/has_description'

require 'caty/task_hash'
require 'caty/task'
require 'caty/indirection'

require 'caty/option_array'
require 'caty/option_constructor'
require 'caty/converters'
require 'caty/option'
require 'caty/global_option'

