Tumble4Ya
===========

A Ruby Gem that adds simple roulette wheel style sorting to any Array object.

## Requirements

Tumble4Ya requires Ruby 2.0+.

## Installation

Add Tumble4Ya to your Gemfile:

```ruby
gem 'tumble_4_ya', :git => "https://github.com/michaeltomko/tumble_4_ya.git", :branch => "master" 
```

And run `bundle install` within your app's directory.

## Usage

Simply call `tumble` on any Array and pass your weighted sorting criteria, as an array of bits, into the block.

```ruby
alcohol = ["beer","champagne"]
drinks = ["juice","milk","beer","champagne"]

["juice","milk","beer","champagne"].tumble do |drink|
  [(drink.length > 4 ? 1 : 0),
   (drink.match(/^j/) ? 1 : 0),
   (alcohol.include?(drink) ? 1 : 0),
   1
  ]
end

# Scoring
=> juice:     [1,1,0,1]
   milk:      [0,0,0,1]
   beer:      [0,0,1,1]
   champagne: [1,0,1,1]

# Sorted Array
=> ["champagne", "juice", "beer", "milk"]
```

While this may not be an extremely valuable use case, the example is used to demonstrate how simple it is to generate descriptive chromosomes for each item in your array by converting boolean operations into binary bits.

When converting a binary number into an integer, the bits are weighted to the left, thus that a bit in the first position will raise the value of the integer higher than those to the right.
