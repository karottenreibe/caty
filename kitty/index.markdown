---
title: Caty -- Kitty
layout: layout
---

# The Kitty application #

The [kitty.rb] file is a simple, small ruby program that demonstrates
most of Caty's functionality.
You can [download it] [kitty.rb] and play with it!
Or you read on and see how it was created.


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

![A picture of a cat playing with a computer mouse][img-catmouse]

So, let's get our kitten eat something. In order to accomplish that,
we add an instance method to the class, like so:

{% highlight ruby %}
def eat
    puts "The kitty eats fish!"
end
{% endhighlight %}

Now we can feed the kitty:

    $> kitty.rb eat
    The kitty eats fish!

But the kitty soon becomes fed up with fish and demands something else.
So let's make this more variable and have the user supply what the kitty
eats:

{% highlight ruby %}
def eat( something )
   puts "The kitty eats #{something}!"
end
{% endhighlight %}

Here the kitty gets some catfood:

    $> kitty.rb eat catfood
    The kitty eats catfood!

That's better! But our little cat is still very hungry, so we add a
switch with which we can determine how much the kitty should eat.

{% highlight ruby %}
task_options :amount => 1

def eat( something )
   puts "The kitty eats #{task_options.amount} #{something}!"
end
{% endhighlight %}

This let's us do the following:

    $> kitty.rb eat mouse
    The kitty eats 1 mouse!
    $> kitty.rb eat mice -amount=3
    The kitty eats 3 mice!


## sleeping ##

![A picture of a sleeping kitten][img-sleeping]

With such a full belly, the kitty now needs to sleep. It strolls into a sunlit
corner and curls itself up into a small hairball:

{% highlight ruby %}
def sleep
    puts 'The kitty sleeps...'
end
{% endhighlight %}

    $> kitty.rb sleep
    The kitty sleeps...

But sometimes the kitty not so much sleeps, but rather just dozes. Although the
two are actually the same. So let's add an alias for sleep:

{% highlight ruby %}
map :doze => :sleep
{% endhighlight %}

    $> kitty.rb doze
    The kitty sleeps...


## meow and purr ##

![A picture of a yawning lion][img-lion]

The little kitten has slept enough and it's in a playful mood now. It meows at
you a lot:

{% highlight ruby %}
def meow
    puts 'meow!'
end
{% endhighlight %}

    $> kitty.rb meow
    meow!

In fact, if you do nothing but look at it, it meows:

{% highlight ruby %}
default :meow
{% endhighlight %}

    $> kitty.rb
    meow!

and even when you feed it and when it's dreaming -- it meows!

{% highlight ruby %}
before do
    puts 'meow!'
end
{% endhighlight %}

    $> kitty.rb eat grass
    meow!
    The kitty eats 1 grass!
    $> kitty.rb sleep
    meow!
    The kitty sleeps...

We'd better stroke it a bit, to calm it down. We best do this everytime we do
something with it:

{% highlight ruby %}
after do
    puts 'purrr...'
end
{% endhighlight %}

    $> kitty.rb eat grass
    meow!
    The kitty eats 1 grass!
    purrr...
    $> kitty.rb sleep
    meow!
    The kitty sleeps...
    purrr...


## quiet ##

Now we're gonna teach our kitty something: to be quiet!

{% highlight ruby %}
global_options do
    boolean :quiet => false
end
{% endhighlight %}

That should calm it down:

{% highlight ruby %}
before do
    puts 'meow!' unless global_options.quiet
end
{% endhighlight %}

    $> kitty.rb eat berry --quiet
    The kitty eats 1 berry!
    purrr...


## Fairy action! ##

![A stone fairy statue][img-fairy]

Then a fairy comes flying by and gives us three wishes. We wish for a
pack of sweets, a rainbow dress (like the one lepachauns wear, you know)
and that our kitty be ablo to speak. We get everything pronto:

{% highlight ruby %}
help_task

# ...

desc('No meowing.')
boolean :quiet, false

# ...

desc('SOMETHING', cut("
    Eats SOMETHING.
    You can give the kitty any -amount of food.
"))
def eat( something )

# ...

desc("Sleeps a bit.")
def sleep

# ...

desc('meow?')
def meow

# ...
{% endhighlight %}

Bewildered we turn to our kitten, which looks at us with smiling eyes, and ask
it:

    $> kitty.rb help
    Commands
    ========

    eat SOMETHING [-amount=1]  # Eats SOMETHING.
    meow                       # meow?
    help [TOKEN]               # Provides help about the program.
    sleep                      # Sleeps a bit.

    Global Options
    ==============

    --quiet=false              # No meowing.

we emit a cry of joy! It worked. Gladly we offer the fairy some of our sweets
and ask the kitty:

    $> kitty.rb help eat
    eat SOMETHING [-amount=1]

    Eats SOMETHING.
    You can give the kitty any -amount of food.

Great! Let's ask another question!

    $> kitty.rb help sleep
    sleep

    Sleeps a bit.

    Aliases: doze

How wise the kitty is!


## separating ##

Now, the kitten has grown older and so have we and it is time to move from
childhood to adultery... ah... I mean adulthood. And that means that the time
of playing and eating all at the same place is over. A serios cat has to learn
to separate work and fun and so we put sleeping in a different location:

{% highlight ruby %}
## sleepy.rb
Kitty.append do

    desc("Sleeps a bit.")
    map :doze => :sleep

    def sleep
        puts 'The kitty sleeps...'
    end

end

## kitty.rb
# ...

class Kitty < Caty
    # ...
end

require 'sleepy.rb'
{% endhighlight %}


# That's it! #

If you followed the above story, you should now know most of Caty's features.
Now grab [the kitty's source] [kitty.rb] and start experimenting!


# Images used on this page #

*   [Sleeping kitten] [sleeping] by alvimann
*   [Cat and mouse] [catmouse] by allie
*   [Lion][] by click (cropped by me)
*   [Fairy][] by taliesin

All those were taken from <http://www.morguefile.com> and are licensed under the
[morgueFile Free License] [mfflicense].


[kitty.rb]:   /caty/kitty/kitty.r                                   "The Kitty example application"
[sleeping]:   http://www.morguefile.com/archive/display/617825      "The picture of the sleeping kitten"
[catmouse]:   http://www.morguefile.com/archive/display/77929       "The picture of the cat and the computer mouse"
[lion]:       http://www.morguefile.com/archive/display/72756       "The uncropped picture of the lion"
[fairy]:      http://morguefile.com/archive/display/148482          "The picture of the fairy"
[mfflicense]: http://morguefile.com/license/morguefile/             "The morgueFile Free License"

[img-catmouse]: /caty/kitty/catandmouse.jpg
[img-lion]:     /caty/kitty/lion.jpg
[img-sleeping]: /caty/kitty/sleeping.jpg
[img-fairy]:    /caty/kitty/fairy.jpg

