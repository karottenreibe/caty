
module Caty::HelpSystem

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
            token_help(task_or_option)
        end
    end

    protected

    #
    # Displays the auto-generated help for all tasks,
    # options and global options known to Caty.
    #
    def help_overview
        task_descs    = self.taskarray.map(&:to_help)
        goption_descs = @global_options.map(&:to_help)
        column_width  = (task_descs + goption_descs).map(&:first).map(&:length).max

        $stdout.puts 'Commands'
        $stdout.puts '========'
        $stdout.puts

        task_descs.each do |desc|
            $stdout.puts "#{desc[0].ljust(column_width)} #{desc[1]}"
        end

        $stdout.puts
        $stdout.puts 'Global Options'
        $stdout.puts '=============='
        $stdout.puts

        goption_descs.each do |desc|
            $stdout.puts "#{desc[0].ljust(column_width)} #{desc[1]}"
        end
    end

    #
    # Displays the auto-generated help for a certain task/option.
    #
    def token_help( token )
        goptions = @global_options
        tasks    = @tasks.to_a

        item     = @tasks.resolve(token) || goptions.find { |item| item.name == token }

        if item.nil? || item.is_a?(Caty::DirectMapping)
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
        @tasks.to_a.reject do |task|
            task.is_a?(Caty::Indirection)
        end
    end

end

