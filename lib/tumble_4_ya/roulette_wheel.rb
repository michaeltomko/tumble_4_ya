require 'tumble_4_ya'

# lib/tumble_4_ya/roulette_wheel.rb
module Tumble4Ya
  # RouletteWheel object auto-populates when initialized.
  class RouletteWheel
    attr_accessor :wheel, :sum

    def initialize(fitnesses)
      @sum = fitnesses.sum

      @wheel = fitnesses.each_with_object([]) do |fitness, obj|
        ((fitness.to_f / sum.to_f) * 100).round.times do
          obj << fitness
        end
      end
    end

    def as_generator
      Enumerator.new do |y|
        loop do
          y.yield wheel.sample
        end
      end
    end
  end
end
