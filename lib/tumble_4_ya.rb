require 'tumble_4_ya/array'
require 'tumble_4_ya/roulette_wheel'
require 'active_support/core_ext/enumerable'

# lib/tumble_4_ya.rb
module Tumble4Ya
  # Tumbler class institutes the roulette wheel genetic algorithm.
  class Tumbler
    def initialize(items, amount)
      @items = items
      @amount = amount
    end

    def tumble(&block)
      perform_sort(*generate_fitnesses_and_load_roulette_wheel(@items, &block))
    end

    def score_items(&block)
      @items.map { |item| { item: item, score: score_item(item, &block) } }
    end

    private

    TO_BINARY = { true => 1, false => 0, 1 => 1, 0 => 0 }

    def perform_sort(items, roulette_wheel)
      roulette_wheel.as_generator.lazy.map do |fitness|
        roulette_wheel.wheel.reject! { |f| f == fitness } if items[fitness].length <= 1
        items[fitness].pop
      end.take(@amount).to_a
    end

    def generate_fitnesses_and_load_roulette_wheel(items, &block)
      fitnessed_items = generate_and_group_by_fitnesses(items, &block)
      roulette_wheel = RouletteWheel.new(fitnessed_items.keys)
      return fitnessed_items, roulette_wheel
    end

    def generate_and_group_by_fitnesses(items, &block)
      items.shuffle.each_with_object({}) do |item, results|
        fitness = calculate_fitness(score_item(item, &block).to_i(2), items.length)
        results[fitness] = (results[fitness].to_a << item)
      end
    end

    def score_item(item)
      (yield item).map do |i|
        (i.respond_to? :call) ? TO_BINARY[i.call] : TO_BINARY[i]
      end.join
    end

    def calculate_fitness(binary, length)
      ((0.25 * (binary * binary)) + (2 * binary) + length).floor
    end
  end
end
