#
# Contains the objects related to the help feature.
#

#
# Will be mixed into the Caty class.
#
module Caty::HelpSystem

    protected

    #
    # Interface for Caty's help system.
    # Displays either a general help page for all tasks
    # and options known to Caty in case no argument was given;
    # or a page descriping a certain task/option.
    #
    def help( task_or_option = nil )
        if task_or_option.nil?
            help_overview
        else
            token_help(task_or_option.to_sym)
        end
    end
    
    #
    # Applies the standard help task
    #
    def help_task
        self.class_eval do
            desc('[TOKEN]', cut("
                Provides help about the program.
                A TOKEN is the name of a task or an option, e.g. 'help' for
                the help task or 'version' for the --version option.
                If a TOKEN is given, help for that specific TOKEN is displayed.
                Otherwise, an overview of all the tasks and options is shown.
            "))
            def help( task_or_option = nil )
                self.class.help(task_or_option)
            end
        end
    end

    private

    #
    # Displays the auto-generated help for all tasks,
    # options and global options known to Caty.
    #
    def help_overview
        task_descs    = @tasks.to_a.reject { |task| task.is_a?(Caty::Indirection) }.map(&:to_help)
        goption_descs = @global_options.map(&:to_help)
        column_width  = (task_descs + goption_descs).map(&:first).map(&:length).max

        $stdout.puts 'Commands'
        $stdout.puts '========'
        $stdout.puts

        task_descs.each do |desc|
            $stdout.puts "#{desc[0].ljust(column_width)}  # #{desc[1]}"
        end

        $stdout.puts
        $stdout.puts 'Global Options'
        $stdout.puts '=============='
        $stdout.puts

        goption_descs.each do |desc|
            $stdout.puts "#{desc[0].ljust(column_width)}  # #{desc[1]}"
        end
    end

    #
    # Displays the auto-generated help for a certain task/option.
    #
    def token_help( token )
        goptions = @global_options
        tasks    = @tasks.to_a
        item     = @tasks.resolve(token) || goptions.find { |item| item.name == token }

        if item.nil?
            $stdout.puts "Sorry, but I don't know `#{token}'"
        else
            aliases = @tasks.find_all do |_,task|
                task.is_a?(Caty::Indirection) and task.target == item.name
            end.map(&:first).join(', ')

            help_text = item.to_help
            $stdout.puts help_text[0]
            $stdout.puts
            $stdout.puts help_text[2]

            unless aliases.empty?
                $stdout.puts
                $stdout.puts "Aliases: #{aliases}"
            end
        end
    end

    #
    # Returns the tasks as an array, with all indirections and removed.
    #
    def taskarray
    end

end

