require 'spec_helper'

describe Tumble4Ya::RouletteWheel do
  let(:fitnesses) { 5.times.map { (0..Random.rand(1000)).to_a.sample } }

  def roulette_wheel(fitnesses)
    @roulette_wheel = Tumble4Ya::RouletteWheel.new(fitnesses)
  end

  it 'should sum the fitnesses given to it' do
    roulette_wheel(fitnesses)
    @roulette_wheel.sum.should == fitnesses.sum
  end

  it 'should generate a 100-item array made up proportionately of the fitnesses fed to it on initialization' do
    roulette_wheel(fitnesses)
    @roulette_wheel.wheel.length.should <= 101
  end

  it 'should provide a Lazy Generator for use in sort operations' do
    roulette_wheel(fitnesses)
    expect(@roulette_wheel.as_generator).to be_a Enumerator
  end
end
