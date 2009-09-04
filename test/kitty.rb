#!/usr/bin/env ruby
require 'rubygems'
require 'caty'

#
# A Kitty.
#
class Kitty < Caty

    global_options do

        #
        # It's trained not to meow if you tell it to be quiet...
        #
        desc('No meowing.')
        boolean :quiet, false

    end

    #
    # It needs to eat sometimes.
    #
    desc('SOMETHING', cut("
        Eats SOMETHING.
        You can tell it to -repeat the eating as often as you like.
    "))
    task_options :repeat => 1

    def eat( something )
        task_options.repeat.times { puts "The kitty eats #{something}!" }
        puts 'meow!' unless global_options.quiet
    end

    #
    # By default the kitty just meows at you.
    #
    def meow
        puts 'meow!' unless global_options.quiet
    end

    default :meow

    #
    # If you ask it politely, it will tell you what it can do.
    #
    help_task

end

#
# You could put this in a separate file and require it here
# instead, thus separating any tasks from the others and
# reducing interdependencies
#
Kitty.append do

    #
    # It can be sleepy...
    #
    desc("Sleeps a bit.")

    def sleep
        puts 'meow!' unless global_options.quiet
        puts 'The kitty sleeps...'
    end

end

#
# Pushes the kitty's on/off switch ;-)
#
Kitty.start!

