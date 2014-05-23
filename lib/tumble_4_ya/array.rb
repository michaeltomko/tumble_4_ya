require 'tumble_4_ya'

class Array
  def tumble(&block)
    if block_given?
      Tumble4Ya::Tumbler.new(self).tumble(&block)
    else
      self.shuffle
    end
  end
end
