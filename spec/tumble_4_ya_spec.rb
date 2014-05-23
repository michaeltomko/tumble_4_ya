require 'spec_helper'

describe Tumble4Ya do
  let(:alcohol) {["beer","champagne"]}
  let(:drinks) {["juice","milk","beer","champagne"]}
  let(:all_zeros) {[0,0,0,0,0,0,0]}

  def try_to_tumble
    @tumbled_array = drinks.tumble do |drink|
      [(drink.length > 4 ? 1 : 0),
        (drink.match(/^j/) ? 1 : 0),
        (alcohol.include?(drink) ? 1 : 0),
        1
      ]
    end  
  end

  def try_to_score
    @scored_array = Tumble4Ya::Tumbler.new(drinks).score_items do |drink|
      [(drink.length > 4 ? 1 : 0),
        (drink.match(/^j/) ? 1 : 0),
        (alcohol.include?(drink) ? 1 : 0),
        1
      ]
    end
  end

  it 'should roulette wheel sort an array' do
    try_to_tumble
    expect(@tumbled_array).to be_a Array
  end

  it 'should shuffle the array in the absence of a block' do
    expect(drinks.tumble).to be_a Array
    expect(alcohol.tumble).to be_a Array
  end

  it 'should handle cases where the array of bits is all zeros' do
    expect(drinks.tumble{|drink| all_zeros }).to be_a Array
  end

  it 'should return scored items when .score_items is called' do
    try_to_score
    expect(@scored_array).to be_a Array
    expect(drinks).to include(@scored_array.first[:item])
  end

  it 'should output the score as a string and the string should only contain 1s and 0s' do
    try_to_score
    expect(@scored_array.first[:score]).to be_a String
    expect(@scored_array.first[:score]).to match(/[01]+/)
  end
  
end
