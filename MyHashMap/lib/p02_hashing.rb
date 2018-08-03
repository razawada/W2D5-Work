class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    # #maybe an alphabet array to get an index of a char to
    # #feed to the Fixnum hash?
    # # alphabet = ('a'..'z').to_a
    #
    # num_string =
    #
    # [2, 7, 5, 4].each do |el|
    #   if el.is_a?(Integer)
    #     el = el
    #   elsif el.is_a?(String)
    #     el = alphabet.index(el)
    #   end
    # end

    num_str = ''
    self.each do |num|
      num_str += num.to_s
    end

    num_str.to_i.hash

    #hash is some number that we get,
    #we are going to iterate through the array to get the hash.
    #arr.reduce
  end
end

class String
  def hash
    alphabet = ('a'..'z').to_a
    str_array = self.split("")
    str_array.each do |ch|
      ch = alphabet.index(ch.downcase)
    end
    str_array.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
