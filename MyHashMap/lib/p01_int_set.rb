class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false) #{false}
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.is_a? Integer
  end

  def validate!(num)
    raise "Not an Integer" unless is_valid?(num)
    raise "Out of bounds" unless num.between?(0,@store.length)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].pop(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if num_buckets == @count
      resize!
    end
    self[num] << num && @count += 1 unless include?(num)
    # @count += 1 unless self[num].include?(num)
  end

  def remove(num)
    self[num].pop(num) && @count -= 1 if include?(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_numbers = []

    @store.each do |bucket|
      bucket.each do |num|
        old_numbers << num
      end
    end

    prev_buckets = num_buckets
    num_buckets = prev_buckets * 2

    @store = Array.new(num_buckets) {Array.new}
    @count = 0

    old_numbers.each {|num| insert(num)}
  end
end
