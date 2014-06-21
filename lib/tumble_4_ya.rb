require 'tumble_4_ya/roulette_wheel'
require 'active_support/core_ext/enumerable'

# lib/tumble_4_ya.rb
module Tumble4Ya
  # Tumbler class institutes the roulette wheel genetic algorithm.
  module Tumbler
    # Perform Roulette Wheel Sort on chained array using block as selection criteria.
    def tumble(amount = length, &block)
      if block_given?
        @amount = amount
        perform_sort(*generate_fitnesses_and_load_roulette_wheel(self, &block))
      else
        shuffle
      end
    end

    # Return a hash of scored items. Useful for debugging.
    def score_items(&block)
      map { |item| { item: item, score: score_item(item, &block) } }
    end

    protected

    TO_BINARY = { true => 1, false => 0, 1 => 1, 0 => 0 }

    # Main iterator.
    def perform_sort(items, roulette_wheel)
      roulette_wheel.as_generator.lazy.map do |fitness|
        roulette_wheel.wheel.reject! { |f| f == fitness } if items[fitness].length <= 1
        items[fitness].pop
      end.take(@amount).to_a
    end

    # Calculates fitnesses for our collection and loads them into a roulette wheel.
    def generate_fitnesses_and_load_roulette_wheel(items, &block)
      fitnessed_items = generate_and_group_by_fitnesses(items, &block)
      roulette_wheel = RouletteWheel.new(fitnessed_items.keys)
      return fitnessed_items, roulette_wheel
    end

    # Calculates fitness and groups the items by fitness into a hash.
    #
    # The call of `shuffle` before calculation/grouping allows for each group to be randomly sorted.
    def generate_and_group_by_fitnesses(items, &block)
      items.shuffle.each_with_object({}) do |item, results|
        fitness = calculate_fitness(score_item(item, &block).to_i(2), items.length)
        results[fitness] = (results[fitness].to_a << item)
      end
    end

    # Yields the scoring block and converts the array of bits to a chromasome.
    def score_item(item)
      (yield item).map do |i|
        (i.respond_to? :call) ? TO_BINARY[i.call] : TO_BINARY[i]
      end.join
    end

    # Purposefully leaving off the -0.25 as called for by the classic formula due to it causing an error in both Ruby and JS.
    def calculate_fitness(binary, length)
      ((0.25 * (binary * binary)) + (2 * binary) + length).floor
    end
  end

  # Adds `tumble` and `score_items` methods to Arrays.
  Array.send :include, Tumbler
end
