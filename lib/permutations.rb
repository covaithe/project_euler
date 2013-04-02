
class Permutations

  def self.of(list, n)
    raise "The list is nil" if list.nil?
    raise "There are not that many items in the list" if n > list.size
    raise "Cannot pick #{n} items from a list" if n < 0
    return [] if n == 0
    return [ list ] if n == list.size
    result = []
    indexes = (0..n-1).to_a
    loop do
      result << choose_values(list, indexes)
      break unless increment_index(indexes, list.size - 1)
    end
    result
  end

  private

  def self.choose_values(list, indexes)
    indexes.map { |i| list[i] }
  end

  def self.increment_index(indexes, max)
    i = indexes.length - 1
    while i >= 0
      if indexes[i] >= max  #can't increment this one
        i -= 1
        max -= 1
      else
        indexes[i] += 1
        1.upto(indexes.length-i-1) do |j|
          indexes[i+j] = indexes[i] + j
        end
        return true
      end
    end
    false
 end
end
