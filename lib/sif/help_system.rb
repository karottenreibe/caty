
module Sif::HelpSystem

        #
        # Interface for Sif's help system.
        # Displays either a general help page for all commands
        # and options known to Sif in case no argument was given;
        # or a page descriping a certain command/option.
        #
        def help( command_or_option = nil )
            if command.nil?
                help_overview
            else
                command_help(command_or_option)
            end
        end

        private

        #
        # Displays the auto-generated help for all tasks,
        # options and global options known to Sif.
        #
        def help_overview
            task_descs = @tasks.reject { |task| task.is_a?(Sif::Indirection) }.map(&:to_help)
            goption_descs = @global_options.map(&:to_help)
            column_width = (task_descs + goption_descs).map(&:first).map(&:length).max

            $stdout.puts 'Commands'
            $stdout.puts '========'
            $stdout.puts

            task_descs.each do |desc|
                $stdout.print "#{desc[0].ljust(column_width)} #{desc[1]}"
            end

            $stdout.puts
            $stdout.puts 'Global Options'
            $stdout.puts '=============='
            $stdout.puts

            goption_descs.each do |desc|
                $stdout.print "#{desc[0].ljust(column_width)} #{desc[1]}"
            end
        end

        #
        # Displays the auto-generated help for a certain task/option.
        #
        def command_help( command )
            name = command.sub(%r{^--}, '')
            tasks = @tasks.reject { |task| task.is_a?(Sif::Indirection) }
            goptions = @global_options

            item = (tasks + goptions).find { |item| item.name == name }

            if item.nil?
                $stdout.puts "Sorry, but I don't know `#{command}'"
            else
                help_text = item.to_help
                $stdout.puts help_text[0]
                $stdout.puts
                $stdout.puts help_text[2]
            end
        end

end

