---
title: Caty -- Compary
layout: layout
---

# Comparison to other parsers #

This page covers some of the other command line parsers and how they differ
from Caty. This is supposed to help you choose the right solution to your
problems (in the rare case where Caty should not fit your needs ;-).


## [Optparse][] ##

Optparse is part of the ruby standard library and thus there's no need to
install a gem to be able to use it.

Unlike Caty, optparse focuses on options only, i.e. there is no notion of
tasks/commands. On the other hand, it allows for quite some complex option
parsing.

Calling `to_s` on your OptionParser object will give you a string that you
can use to print as a help screen.
Furthermore, optparse will complain if you provide options on the command
line that it doesn't know about.


## [Optiflag][] ##

This neat gem follows the same notion as optparse, but executes it in a
completely different way.

Like optparse, it only processes options, no commands or the like, and
like optparse it can do so in a very sophisticated way.
But unlike optparse, who passes you an OptionParser object on which you
call methods to trigger the option parsing, Optiflag uses a DSL syntax
to do all the configuration.

Optiflag also has a usage screen and an extended help screen featuring
all the defined options. It can also show option specific help.

As a special feature, Optiflag can [use any of your classes] [of-classparse]
as a template and parse the command line according to its `attr_accessor`s.


## [CommandLine::OptionParser] [cmdline] ##

This fellow here is again a pure option parser (as the title suggests).
It has numerous features and follows the Unix/GNU/XToolkit command line
styles.

Its options are constructed in a way similar to Optparse. The same is
true for the help screen, which is also generated with `to_s`.


## [Trollop][] ##

Trollop is somewhat different from the above, since it does support
tasks to some extent, i.e. it will parse global options left of the
command and task specific options only right of it. Also you have to
run a case-when over the retrieved command yourself.

On the other hand, it is very, very space saving when it comes to pure
option parsing, needing only one line of code per option.

It features a version and help screen and has a special `die` function
that consistently handles option errors and application exit messages.


## [Choice][] ##

Another DSL-style option-only parser, that can also be operated in a
one-line way. But since it wasn't developed to be one-line, it looks
a bit forced and takes much more space than Trollop.

Features a full fledged help system.


## [cmdparse] ##

The only other library I found that supports the notion of commands/tasks.
It implements them with one subclass per command, which creates quite some
code overhead.

It supports subcommands and default commmands and can handle options by
wrapping the optparse library.

## [ARGV.delete!] [argv] ##

Or "the manual method". Real easy for scripts with 2 or 3 boolean switches.
No overhead whatsoever. Totally unsuitable for anything larger or more
complicated.

# More! #

There are tons more of those parsers and probably 1000 hand brewn
solutions floating around on folks' desktops. I can't list all of them
here, so if neither Caty, nor any of the aforementioned did the trick
-- [go on and search a bit yourself] [googlecmd].


[optparse]:         http://www.ruby-doc.org/stdlib/libdoc/optparse/rdoc/index.html                               "The optparse library"
[optiflag]:         http://optiflag.rubyforge.org/index.html                                                     "The Optiflag gem"
[of-classparse]:    http://optiflag.rubyforge.org/example_8.html                                                 "Special ability of OptiFlag"
[cmdline]:          http://rubyforge.org/docman/view.php/632/170/index.html                                      "The Commandline::OptionParser gem"
[trollop]:          http://trollop.rubyforge.org/                                                                "The Trollop gem"
[choice]:           http://choice.rubyforge.org/                                                                 "The Choice gem"
[argv]:             http://stackoverflow.com/questions/897630/really-cheap-command-line-option-parsing-in-ruby   "The manual method"
[getoptlong]:       http://www.ruby-doc.org/stdlib/libdoc/getoptlong/rdoc/index.html                             "The getoptlong gem"
[cmdparse]:         http://cmdparse.rubyforge.org/tutorial.html                                                  "The cmdparse gem"
[googlecmd]:        http://www.google.de/search?q=ruby+command+line+parsing                                      "Google search for Ruby command line parsers"   

