---
title: Caty -- Compary
layout: layout
---

# Comparisons #

This page covers some of the other command line parsers and how they differ
from Caty. This is supposed to help you choose the right solution to your
problems (in the rare case where Caty should not fit your needs ;-).

## [Optparse][] ##

Optparse is part of the ruby standard library and thus there's no need to
install a gem to be able to use it.

Unlike Caty, optparse focuses on options only, i.e. there is no notion of
tasks/commands. On the other hand, it allows for quite some complex option
parsing.

## [Optiflag][] ##

This neat gem follows the same notion as optparse, but executes it in a
completely different way.

Like optparse, it only processes options, no commands or the like, and
like optparse it can do so in a very sophisticated way.
But unlike optparse, who passes you an OptionParser object on which you
call methods to trigger the option parsing, Optiflag uses a DSL syntax
to do all the configuration.


[optparse]:   http://www.ruby-doc.org/stdlib/libdoc/optparse/rdoc/index.html   "The optparse library"
[optiflag]:   http://optiflag.rubyforge.org/index.html                         "The Optiflag gem"

