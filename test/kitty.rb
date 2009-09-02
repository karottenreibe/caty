#!/usr/bin/env ruby
require 'rubygems'
require 'caty'

class Kitty < Caty

    global_options do
        desc("No meowing")
        boolean :quiet, false
    end

    desc("WHAT", "eats something\nWHAT is the food")
    task_options :s => :string
    def eat( what )
        puts "eating #{what} #{task_options.s}!" unless global_options.quiet
    end

    desc("sleeps a bit")
    def sleep
        puts "sleeping..." unless global_options.quiet
    end

    help_task

end

Kitty.start!

