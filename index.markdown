---
title: Caty -- Command line parsing in Ruby
layout: layout
---


![Caty at work with the Kitty application] [image]

# What is Caty? #

Caty is a framework (oh that word...) for parsing command line arguments
in Ruby. It is intended for projects that are of medium size and offers
great facilities to easily rig your application with command line
capabilities. It was designed to be as subtle as possible.

It needs minimal code overhead to set up, but to do so it imposes a
certain schema on the command line interface of your program.

It does so by directly mapping directives (so-called **tasks**) from the
user's arguments to instance methods of a class in your application.

It also supports

*   **arguments** to tasks mapped directly to the instance methods'
    argument list
*   options -- both application global (`--debug`) and task specific
    (`-d`)
*   providing aliases to tasks (so-called **mappings**)

And features a **help system** (`app.rb help` and `app.rb help sometask`)
that resembles rake's `desc` system.

Furthermore it provides some functionality to allow for easier **separation
of concers**.


# Getting to know Caty #

You can take a peek at the [presentation about Caty] [presentation], a
small, roughly 10 minute slide show that tells you the basics of Caty in
a nice, enjoyable way.

Or you could also have a look at the [Kitty app] [kitty], a small sample
application that features the gros of Caty's features in a compressed way.

Also, there's the [rdoc] documentation.

And finally you could use any of the other [resources].


# Applications that use Caty #

These applications use Caty for their command line parsing:

*   [tdr][] -- A todo list manager for the console

If you know any more, I'd love to put them up here!


# Alternatives #

There are numerous alternatives to Caty, which you might want to consider
as well. For a detailed comparison with Caty, see [the comparison page] [comparison].


# Thanks #

Caty was inspired by the great [Thor][], the known-to-all [Rake][].
Both helped me find the way in this topic.

[thor]:          http://yehudakatz.com/2008/05/12/by-thors-hammer/  "The great Thor, an inspiration for Caty"
[rake]:          http://rake.rubyforge.org/                         "The great Rake, an inspiration for Caty"

[presentation]:  /presenty                                          "A presentation about Caty -- great for a quick introduction"
[kitty]:         /kitty                                             "The kitty application -- a small show-off of Caty's functionalities"
[comparison]:    /comparison.html                                   "A comparison of Caty and other Ruby command line parsers"
[rdoc]:          /rdow                                              "Caty's rdoc documentation"
[resources]:     /resources.html                                    "Other resources around Caty"

[tdr]:           http://github.com/karottenreibe/tdr                "tdr -- A console todo manager written in Ruby"

[image]:         /question.png                                      "A big questionmark"

