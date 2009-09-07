# Caty #

*   http://github.com/karottenreibe/caty


## Description ##

Caty is a command line parser that operates on the same
principle as Yehuda Katz's Thor (http://github.com/wycats/thor/tree/master).
It maps the arguments given by the user to instance methods of a class
and can automatically parse options.


## Features ##

* Define tasks that get mapped directly to instance methods of a class
* Define global (e.g. --beer) and task-specific (e.g. -rootbeer) options
* Have String, Integer and Boolean options
* Have options with default values


## Synopsis ##

    require 'rubygems'
    require 'caty'

    class Kitty < Caty

        global_options do
            boolean :quiet, false
        end

        desc('WHAT', cut("
            Kitty's hungry!
            You can specify any amount of food to feed the kitty.
        "))

        task_options :amount => 1

        def eat( something )
            unless global_options.quiet
                puts "I'm eating #{something}. I'm #{task_options.speed}!"
            end
        end

        help_task

    end

    Kitty.start!


    #
    # now you can do:
    # $> kitty eat fish -amount=5 --quiet
    # $> kitty help
    # ...
    #



## Install ##

* sudo gem install karottenreibe-caty --source http://gems.github.com
* sudo gem install caty


## License ##

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

