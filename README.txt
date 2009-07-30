= sif

* http://github.com/karottenreibe/sif

== DESCRIPTION:

Sif is a commandline parser that operades on the same
principle as Yehuda Katz's Thor (http://github.com/wycats/thor/tree/master).

Actually it's just a mean rip-off with some quirks removed
and some new features ... :-)

== FEATURES/PROBLEMS:

* Define tasks that get mapped directly to instance methods of a class
* Define global (e.g. --beer) and task-specific (e.g. -rootbeer) options
* Have String, Integer and Boolean options
* Have optional options and options with default values

== SYNOPSIS:

    require 'rubygems'
    require 'sif'

    class BarBeQue < Sif

        global_options :silent => false

        task_options :speed => 1
        desc 'WHAT', "Eats stuff.\nThe speed determines how fast eating will go."
        def eat( what )
            unless global_options.silent
                puts "eating #{what} #{task_options.speed}x as fast!"
            end
        end

    end

    BarBeQue.start!

== INSTALL:

* sudo gem install karottenreibe-sif --source http://gems.github.com

== LICENSE:

/*---- DON'T PANIC License 1.1 -----------

  Don't panic, this piece of software is
  free, i.e. you can do with it whatever
  you like, including, but not limited to:
  
    * using it
    * copying it
    * (re)distributing it
    * burning/burying/shredding it
    * eating it
    * using it to obtain world domination
    * and ignoring it
  
  Under the sole condition that you
  
    * CONSIDER buying the author a strong
      brownian motion producer, say a nice
      hot cup of tea, should you ever meet
      him in person.

----------------------------------------*/

