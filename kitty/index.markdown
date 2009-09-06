---
title: Caty -- Kitty
layout: layout
---

# The Kitty application #

The [kitty.rb] file is a simple, small ruby program that demonstrates
most of Caty's functionality.


## How it works ##

Now, what exactly does our kitty do? As every kitty, it loves to just
lay in the sun, doze and sleep, sleep and doze. Now and then it has to
eat a bit, sometimes fish, sometimes a mouse. During all of this, the
kitty likes to meow a bit and purr a while.


## skeleton ##

First, let's lay out the skeleton of the application:

{% highlight ruby %}
require 'rubygems'
require 'caty'

class Kitty < Caty
end

Kitty.start!
{% endhighlight %}

That's it already. Now we only have to populate the Kitty class
and we're set.


## eating ##

So, let's get our kitten eat something. In order to accomplish that,
we add an instance method to the class, like so:

{% highlight ruby %}
def eat
    puts "The kitty eats fish!"
end
{% endhighlight %}

But the kitty soon becomes fed up with fish and demands something else.
So let's make this more variable and have the user supply what the kitty
eats:

{% highlight ruby %}
def eat( something )
   puts "The kitty eats #{something}!"
end
{% endhighlight %}

That's better! But our little cat is still very hungry, so we add a
switch with which we can determine how much the kitty should eat.

{% highlight ruby %}
task_options :amount => 1
def eat( something )
   puts "The kitty eats #{task_options.amount} #{something}!"
end
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}

{% highlight ruby %}
{% endhighlight %}


[kitty.rb]:   /kitty/kitty.rb     "The Kitty example application"

