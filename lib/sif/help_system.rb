
module Sif::HelpSystem

        #
        # Interface for Sif's help system.
        # Displays either a general help page for all commands
        # and options known to Sif in case no argument was given;
        # or a page descriping a certain command/option.
        #
        def help( command_or_option = nil )
            if command_or_option.nil?
                help_overview
            else
                command_help(command_or_option)
            end
        end

        protected

        #
        # Displays the auto-generated help for all tasks,
        # options and global options known to Sif.
        #
        def help_overview
            task_descs = self.taskarray.map(&:to_help)
            goption_descs = @global_options.map(&:to_help)
            column_width = (task_descs + goption_descs).map(&:first).map(&:length).max

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
        def command_help( command )
            name = command.sub(%r{^--}, '')
            goptions = @global_options
            tasks = self.taskarray

            item = (tasks + goptions).find { |item| item.name == name }
            aliases = @tasks.find_all do |name,task|
                task.is_a?(Sif::Indirection) and task.target == command
            end.map(&:first).join(', ')

            if item.nil?
                $stdout.puts "Sorry, but I don't know `#{command}'"
            else
                help_text = item.to_help
                $stdout.puts help_text[0]
                $stdout.puts
                $stdout.puts help_text[2]
                $stdout.puts
                $stdout.puts "Aliases: #{aliases}"
            end
        end

        #
        # Returns the tasks as an array, with all indirections and
        # direct mappings removed.
        #
        def taskarray
            @tasks.to_a.reject do |task|
                task.is_a?(Sif::Indirection) or task.is_a?(Sif::DirectMapping)
            end
        end

end

