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

    Copyright (c) 2009 Fabian Streitel

    Permission is hereby granted, free of charge, to any person
    obtaining a copy of this software and associated documentation
    files (the "Software"), to deal in the Software without
    restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following
    conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
    OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
    HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
    OTHER DEALINGS IN THE SOFTWARE.

