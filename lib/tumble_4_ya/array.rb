require 'tumble_4_ya'

class Array
  def tumble(amount = self.length, &block)
    if block_given?
      Tumble4Ya::Tumbler.new(self, amount).tumble(&block)
    else
      self.shuffle
    end
  end
end
