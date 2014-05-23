require 'spec_helper'

describe Tumble4Ya do
  let(:alcohol) {["beer","champagne"]}
  let(:drinks) {["juice","milk","beer","champagne"]}

  def try_to_tumble
    @tumbled_array = drinks.tumble do |drink|
      [(drink.length > 4 ? 1 : 0),
        (drink.match(/^j/) ? 1 : 0),
        (alcohol.include?(drink) ? 1 : 0),
        1
      ]
    end  
  end

  it 'roulette wheel sorts an array' do
    try_to_tumble
    expect(@tumbled_array).to be_a Array
  end
end
