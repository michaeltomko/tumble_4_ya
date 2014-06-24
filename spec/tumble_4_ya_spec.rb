require 'spec_helper'

describe Tumble4Ya do
  let(:alcohol) { %w(beer champagne) }
  let(:drinks) { %w(juice milk beer champagne) }
  let(:all_zeros) { [0, 0, 0, 0, 0, 0, 0] }
  let(:true_false) { [true, false] }
  let(:binary) { [1, 0] }
  let(:criteria) { binary + true_false }

  def test_criteria(drink)
    [
      -> { drink.length > 4 },
      (drink.match(/^j/) ? 1 : 0),
      alcohol.include?(drink),
      false,
      1
    ]
  end

  def try_to_tumble
    @tumbled_array = drinks.tumble do |drink|
      test_criteria(drink)
    end
  end

  def try_to_score
    @scored_array = drinks.score_items do |drink|
      test_criteria(drink)
    end
  end

  it 'should roulette wheel sort an array' do
    try_to_tumble
    expect(@tumbled_array).to be_a Array
    @tumbled_array.should_not == drinks
  end

  it 'should shuffle the array in the absence of a block' do
    match = 0
    not_match = 0
    10.times do
      drinks == drinks.tumble ? match += 1 : not_match += 1
    end
    not_match.should > match
  end

  it 'should accept Procs as criteria for sorting' do
    match = 0
    not_match = 0
    sorted_array = []
    10.times do
      sorted_array = drinks.tumble do |drink|
        [
          -> { drink.length > 4 },
          -> { drink.match(/^j/) ? 1 : 0 },
          -> { alcohol.include?(drink) }
        ]
      end
      sorted_array == drinks ? match += 1 : not_match += 1
    end
    not_match.should > match
  end

  it 'should accept TrueClass/FalseClass values as criteria for sorting' do
    match = 0
    not_match = 0
    sorted_array = []
    10.times do
      sorted_array = drinks.tumble { true_false }
      sorted_array == drinks ? match += 1 : not_match += 1
    end
    not_match.should > match
  end

  it "should accept 1's and 0's as criteria for sorting" do
    match = 0
    not_match = 0
    sorted_array = []
    10.times do
      sorted_array = drinks.tumble { binary }
      sorted_array == drinks ? match += 1 : not_match += 1
    end
    not_match.should > match
  end

  it 'should handle cases where the array of bits is all zeros' do
    expect(drinks.tumble { all_zeros }).to be_a Array
  end

  it 'should return scored items when .score_items is called' do
    try_to_score
    expect(@scored_array).to be_a Array
    expect(@scored_array.first).to be_a Hash
    expect(drinks).to include(@scored_array.first[:item])
  end

  it 'should output the score as a string and the string should only contain 1s and 0s' do
    try_to_score
    expect(@scored_array.first[:score]).to be_a String
    expect(@scored_array.first[:score]).to match(/[01]+/)
  end

end
