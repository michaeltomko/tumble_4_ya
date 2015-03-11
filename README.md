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

Tumble4Ya is a Ruby implementation of the sorting algorithm from my now-defunct Spotify application, [Rock Tumbler](https://github.com/michaeltomko/rock-tumbler), which was originally written in JavaScript, with some help from the [Lazy.js](http://danieltao.com/lazy.js/) library — which I spoke about at the [March 20, 2014 meeting of the St. Louis JavaScript group](https://www.youtube.com/watch?v=GDOeQ2n3GzI). *(For the record, Rock Tumbler is only defunct because Spotify has abandoned their developer program. I used that application for nearly 8 hours a day for at least a year and I continue to miss it every day. Their web API does not expose enough of what I need to reuse Rock Tumbler, although I have considered different reinterpretations of it to revive at least some of its best core functions.)*

I found myself constantly dissatisfied with the results of using Ruby's built-in `.shuffle` method but overwhelmed at the overhead of trying to implement a more complicated sorting algorithm into the general flow of my application — especially when the "need" may not warrant such an undertaking. The use case that initially caused me to write this gem is outlined below but Tumble4Ya is my attempt at porting the raw power of a Roulette Wheel Sorting Algorithm into a simple, chainable method that can be applied to any Array.

## Roulette Wheel Sorting

![Image from Newcastle University Engineering Design Center: http://www.edc.ncl.ac.uk/highlight/rhjanuary2007g02.php/](http://www.edc.ncl.ac.uk/assets/hilite_graphics/rhjan07g02.png)

> "Roulette Wheel Selection mimics the way a traditional roulette wheel works by assigning each member of the population to a “slot” on the wheel, but “rigs” the odds by assigning more slots to those more desirable chromosomes."

> via [John Svazic: Growing The Money Tree](http://growingthemoneytree.com/roulette-wheel-selection/)

## Usage

Simply call `.tumble` on any Array and pass your weighted sorting criteria into the block. Failing to include a block will cause Tumble4Ya to simply act as an alias for the default `.shuffle` method.

You can provide your criteria by constructing an Array of **Boolean (true or false)** and/or **Binary (1 or 0)** values inside of the block, like so…

```ruby
alcohol = ["beer", "champagne"]
drinks = ["juice", "milk", "beer", "champagne"]

drinks.tumble do |drink|
  [
    -> { drink.length > 4 },
    (drink.match(/^j/) ? 1 : 0),
    alcohol.include?(drink),
    false,
    1
  ]
end

# Sorted Array
=> ["champagne", "juice", "beer", "milk"]
```

Tumble4Ya will loop over any Array of Procs, conditionals, 1's and 0's, and TrueClass/FalseClass values.

You can also choose to take just the top N items by passing an **amount** attribute to `tumble`…

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

While this may not be an extremely valuable use case, the example is used to demonstrate how simple it is to generate descriptive chromosomes for each item in your array by converting boolean operations into binary bits.

When converting a binary number into an integer, the bits are weighted to the left, thus that a bit in the first position will raise the value of the integer higher than those to the right. The higher the value of the integer, or "fitness" in this case, will give those elements a higher probability of selection on each spin of the wheel.

## Debugging

Sometimes it can be useful to see how your criteria will actually score your array elements. Calling `.score_items` on an Array, and passing to it a block, will output each item's score so that you can see how your criteria are performing.

```ruby
# Output based on the criteria from the first example.
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
