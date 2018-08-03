require 'byebug'
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    next_node = @next
    prev_node = @prev
    next_node.prev = prev_node
    prev_node.next = next_node
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :tail
  def initialize
    # @empty_list = []
    @head = Node.new
    @tail = Node.new
    # @empty_list.append(@head)
    # @empty_list.append(@tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    #just reassign right in front of the tail, and things should function
    #reappends there as the tail is a sentinel.
    previous_node = @tail.prev
    previous_node.next = new_node
    @tail.prev = new_node
    new_node.next = @tail
  end

  def update(key, val)
    #update as this new node previously
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    unless empty?
      self.each do |node|
        if node.key == key
          previous_node = node.prev
          next_node = node.next #node.prev = new_node
          previous_node.next = next_node
          new_node.prev = previous_node
          # node.remove

        end
      end
    end
  end

  def each
    return if self.empty?
    current_node = first
    until current_node == @tail
      yield(current_node)
      current_node = current_node.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
