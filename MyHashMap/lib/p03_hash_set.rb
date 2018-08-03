class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if num_buckets == @count
      resize!
    end
    self[key] << key && @count += 1 unless include?(key)
    # @count += 1 unless self[key].include?(key)
  end

  def remove(key)
    self[key].pop(key) && @count -= 1 if include?(key)
  end

  def include?(key)
    self[key].include?(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
