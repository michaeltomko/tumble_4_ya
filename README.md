Tumble4Ya
===========

A Ruby Gem that adds simple roulette wheel style sorting to any Array object.

[![Build Status](https://travis-ci.org/michaeltomko/tumble_4_ya.svg?branch=master)](https://travis-ci.org/michaeltomko/tumble_4_ya) [![Coverage Status](https://img.shields.io/coveralls/michaeltomko/tumble_4_ya.svg)](https://coveralls.io/r/michaeltomko/tumble_4_ya)

> ![Culture Club](http://24.media.tumblr.com/tumblr_mc0t7x0FAc1r3ifxzo1_500.gif)

> I'll tumble 4 ya.

## Requirements

Tumble4Ya requires Ruby 2.0+.

## Installation

Add Tumble4Ya to your Gemfile…

```ruby
gem 'tumble_4_ya', :git => "https://github.com/michaeltomko/tumble_4_ya.git", :branch => "master" 
```

…and run `bundle install` within your app's directory.

## Purpose

Tumble4Ya is a Ruby implementation of the sorting algorithm from my now-defunct Spotify application, [Rock Tumbler](https://github.com/michaeltomko/rock-tumbler), which was originally written in JavaScript, with some help from the [Lazy.js](http://danieltao.com/lazy.js/) library — which I spoke about at the [March 20, 2014 meeting of the St. Louis JavaScript group](https://www.youtube.com/watch?v=GDOeQ2n3GzI).

I found myself constantly dissatisfied with the results of using Ruby's built-in `.shuffle` method but overwhelmed at the overhead of trying to implement a more complicated sorting algorithm into the general flow of my application — especially when the *budget* may not warrant such an undertaking.

The original use case that inspired me to write this gem is outlined below but ultimately, Tumble4Ya is my attempt at porting the raw power of a Roulette Wheel Sorting Algorithm into a simple, chainable method that can be applied on-the-fly to any Array.

## Roulette Wheel Sorting

![Image from Newcastle University Engineering Design Center: http://www.edc.ncl.ac.uk/highlight/rhjanuary2007g02.php/](http://www.edc.ncl.ac.uk/assets/hilite_graphics/rhjan07g02.png)

> "Roulette Wheel Selection mimics the way a traditional roulette wheel works by assigning each member of the population to a “slot” on the wheel, but “rigs” the odds by assigning more slots to those more desirable chromosomes."

> via [John Svazic: Growing The Money Tree](http://growingthemoneytree.com/roulette-wheel-selection/)

## Usage

Simply call `.tumble` on any Array and pass your weighted sorting criteria into the block, as an Array of **Boolean (true or false)** and/or **Binary (1 or 0)** values. Failing to include a block will cause Tumble4Ya to simply act as an alias for the default `.shuffle` method.

You can also choose to take just the top N items by passing an **amount** attribute to `.tumble`, like `.tumble(2)` or `.tumble(100)`. Omitting the amount will return an Array of equal length of the original Array.

## Example

I was building a "lifestream" grid that contained social media posts from Twitter, Facebook, Instagram, Tumblr, and snippets from misc. blogs. This was a unique challenge because the topic that these posts all represented was about all that they had in common. Using Ruby's built-in "random" sorting capabilities caused the grid to look disorganized, as the visual representation of this random sort appeared to be oddly clustered and subsequently resorting with the same mechanism caused similarly ugly sorts.

Using Tumble4Ya, I am able to weight the sorting of these posts based on an unlimited number of criteria, like so.

```ruby
def sorted_grid_messages
  messages.tumble do |message|
    [message_primary_sentiment_participation_as_binary(@stats.sentiments[message.sentiment]),
     message_secondary_sentiment_participation_as_binary(@stats.sentiments[message[:sentiment]]),
     message_contains_hashtags_as_binary(message.content),
     message_source_participation_as_binary(@stats.sources[message[:source]]),
     message_content_length_acceptance_as_binary(message.content.length),
     message_type_participation_as_binary(stats.types[message[:type]]),
     control_bit
    ]
  end
end
```

Weighting of the criteria is organized left (greatest) to right (least). From left to right, the criteria for this sort are as follows…

* The scored sentiment of this message comprises greater than or equal to 50% of the overall sentiment breakdown of messages. *(ex. The message is scored as "positive" and more than 50% of all of the messages are positive.)*
* The scored sentiment of this message comprises less than or equal to 20% of the overall sentiment breakdown of messages.
* The text of this message contains at least one hashtag.
* The source of this message (Twitter, Facebook, etc.) comprises 50% or greater of the overall source breakdwon of messages.
* The content length of this message is less than or equal to 300 characters.
* The type of this message (photo or text) comprises less than or equal to 50% of the overall type breakdown of messages.
* A control bit, so that no message is scored as a zero.

Playing with these values allowed me to quickly concoct an algorithm for sorting these social media posts in a way that was visually both random and balanced, with different types, sources, sentiments, and lengths more evenly distributed throughout the grid.

## Debugging

Sometimes it can be useful to see how your criteria will actually score your array elements. Calling `.score_items` on an Array, and passing to it a block, will output each item's score so that you can see how your criteria are performing.

Take a simple, impractical example…

```ruby
alcohol = ["beer", "champagne"]
drinks = ["juice", "milk", "beer", "champagne"]

drinks.tumble(2) do |drink|
  [
    -> { drink.length > 4 },
    (drink.match(/^j/) ? 1 : 0),
    alcohol.include?(drink),
    false,
    1
  ]
end

# Sorted Array
=> ["champagne", "juice"]
```

…and let's debug its operation.

```ruby
drinks.score_items do |drink|
  [
    -> { drink.length > 4 },
    (drink.match(/^j/) ? 1 : 0),
    alcohol.include?(drink),
    false,
    1
  ]
end

# Scored output
=> {
    item: "juice", score: "11001",
    item: "milk",  score: "00001",
    item: "beer", score: "00101",
    item: "champagne, score: "10101"
   }
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

> ![Culture Club](http://media.giphy.com/media/12ayoOAjHcjUaI/giphy.gif)
