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
        You can give the kitty any -amount of food.
    "))
    task_options :amount => 1

    def eat( something )
        puts "The kitty eats #{task_options.amount} #{something}!"
    end

    #
    # By default the kitty just meows at you.
    #
    def meow
        puts 'meow!'
    end

    default :meow

    #
    # It likes to meow a lot.
    #
    before do |task|
        puts 'meow!' unless global_options.quiet or task == :help
    end

    #
    # And it tells you when it's done.
    #
    after do |task|
        puts 'purrr...' unless task == :help
    end

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
    # And doze away...
    #
    desc("Sleeps a bit.")
    map :doze => :sleep

    def sleep
        puts 'The kitty sleeps...'
    end

end

#
# Pushes the kitty's on/off switch ;-)
#
Kitty.start!

