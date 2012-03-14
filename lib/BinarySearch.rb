
module BinarySearch

  def bin_include?(n)
    nil != self.bin_indexof(n)
  end

  def bin_indexof(n)
    low = 0
    high = self.length-1

    while low <= high
      mid = (low + high)/2
      p = self[mid]

      if p < n
        low = mid + 1
      elsif p > n
        high = mid-1
      else
        return mid
      end
    end
    
    return nil 
  end
end

class Array
  include BinarySearch
end
