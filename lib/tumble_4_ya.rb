require 'tumble_4_ya/array'

class Tumble4Ya < Struct.new(:items)
  def tumble(&block)
    perform_roulette_wheel_sort(*generate_fitnesses_and_load_roulette_wheel(items, &block))
  end

  private
  def perform_roulette_wheel_sort(items, wheel)
    roulette_wheel_as_generator(wheel).lazy.collect do |fitness|
      item = items[fitness].pop
      wheel.reject!{|f| f == fitness } if items[fitness].empty?
      item
    end.take(items.values.map(&:length).sum).to_a
  end

  def generate_fitnesses_and_load_roulette_wheel(items, &block)
    fitnessed_items = generate_and_group_by_fitnesses(items, &block)
    roulette_wheel = load_roulette_wheel(fitnessed_items.keys)
    return fitnessed_items, roulette_wheel
  end

  def generate_and_group_by_fitnesses(items, &block)
    items.shuffle.each_with_object({}) do |item,results|
      fitness = calculate_fitness((yield item).join.to_i(2),items.length)
      results[fitness] = (results[fitness].to_a << item)
    end
  end

  def calculate_fitness(binary,length)
    ((0.25*(binary*binary))+(2*binary)+length).floor
  end    

  def load_roulette_wheel(fitnesses)
    sum = fitnesses.sum

    fitnesses.each_with_object([]) do |fitness,obj| 
      ((fitness.to_f/sum.to_f)*100).round.times do |t|
        obj << fitness
      end 
    end
  end

  def roulette_wheel_as_generator(wheel)
    Enumerator.new do |y|
      loop do
        y.yield wheel.sample
      end
    end
  end
end
