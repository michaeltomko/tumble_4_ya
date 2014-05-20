tumble_4_ya
===========

A Ruby Gem that extends adds simple roulette wheel sorting to Array objects.

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
alchol = ["beer","champagne"]
drinks = ["juice","milk","beer","champagne"]

["juice","milk","beer","champagne"].tumble do |drink|
  [(drink.length > 4 ? 1 : 0),
   (drink.match(/^j/) ? 1 : 0),
   (alcohol.include?(drink) ? 1 : 0),
   1
  ]
end
```
