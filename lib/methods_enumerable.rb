module Enumerable
  def my_each
    for item in self
      yield item
    end
  end

  def my_each_with_index
    i = 0
    for item in self
      yield(item, i)
      i += 1
    end
  end

  def my_select
      res = []
      my_each { |v| res.push(v) if yield(v) }
      return res
  end


  def my_all?(pattern = nil)
    if block_given?
      my_each { |v| return false unless yield(v) }
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        my_each { |v| return false unless pattern =~ v.to_s }
      elsif pattern.class == Class 
        my_each { |v| return false unless v.is_a?(pattern)}
      else
        my_each { |v| return false unless v == pattern }
      end
    else
      my_each { |v| return false unless v }
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given?
      my_each { |v| return true if yield(v) }
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        my_each { |v| return true if pattern =~ v.to_s }
      else
        my_each { |v| return true if v.is_a?(pattern) }
      end
    else
      my_each { |v|  v != nil ?  true : false }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |v| return false if yield(v) }
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        my_each { |v| return false if pattern =~ v.to_s }
      else
        my_each { |v| return false if v.is_a?(pattern) }
      end
    else
      my_each { |v|  return false if v }
    end
    true
  end

  def my_count(comp = nil)
    res = 0
    if block_given?
      my_each { |v| res += 1 if yield(v) }
    elsif !comp.nil?
      my_each { |v| res += 1 if v == comp }
    else
      res = size
    end
    res
  end

  def my_map(proc = nil)
    res = []
    return to_enum(__method__) unless block_given?
    if proc.nil? 
      my_each { |v| res.push(yield v) }
    else
      my_each { |v| res.push(proc.call(v)) }
    end
    res
  end

  def my_inject(arg = nil)
    acc ,nxt, start = nil , nil, nil
    if arg.nil?
      acc = self[0]
      nxt = self[1]
      start = 1
    else
      acc = arg
      nxt = self[0]
      start = 0
    end

    if block_given?
      for i in start...self.size
        acc = yield(acc, nxt)
        nxt = self[i+1]
      end
      acc
    end  
  end


end

def multiply_els(arr)
  arr.my_inject{|a,b| a*b}
end
arr=[3,4,6,8,7]
hash={a: 1, b: 2}

# print arr.my_inject(2){|a,b| a + b}

# TEST

#arr.my_each{|item| puts item.to_s}
#hash.my_each{|item| puts item.to_s}

#arr.my_each_with_index { |v, i| puts "#{v} at index #{i}" }
#hash.my_each_with_index { |k, v, i| puts "#{k}: #{v} at index #{i}" }


#print [1, 2, 2, 3, 5, 8, 9].my_select(&:odd?)
#print hash.my_select { |k, v| v > 1 }

 puts arr.my_all?(/\D/)
 puts arr.my_all?(String)
 puts hash.my_all? { |k, v| v.is_a? Integer }
 puts hash.my_all?(/\d/)
 puts hash.my_all?(3)

# print arr.my_any?
# print [1, 2, nil, 3, 5, 8, 9].my_any? { |v| v || v.nil? }
# print arr.my_any?(/\d/)

# print arr.my_none?
# print [1, 2, nil, 3, 5, 8, 9].my_none? { |v| v || v.nil? }
# print arr.my_none?(/\d/)

# print arr.my_count
# print arr.my_count(2)
# print arr.my_count{ |x| x%2==0 }

# test = Proc.new { |i| i*i } 
# print arr.my_map( &test)
# print arr.my_map { |i| i*i }

#print [1,2,3,4,5].my_inject{|a,b| a+b}

# print multiply_els(arr)

