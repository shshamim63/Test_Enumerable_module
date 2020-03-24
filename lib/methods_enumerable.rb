module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    arr = to_a.dup
    for item in arr
      yield item
    end
    arr
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    i = 0
    arr = to_a.dup
    for item in self
      yield(item, i)
      i += 1
    end
    arr
  end

  def my_select
    return to_enum(:my_select) unless block_given?
    res = []
    my_each { |v| res.push(v) if yield(v) }
    res
  end

  def my_all?(pattern = nil)
    if block_given?
      my_each { |v| return false unless yield(v) }
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        my_each { |v| return false unless pattern =~ v.to_s }
      elsif pattern.class == Class
        my_each { |v| return false unless v.is_a?(pattern) }
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
    elsif pattern
      if pattern.is_a?(Regexp)
        my_each { |v| return true if pattern =~ v.to_s }
      elsif pattern.class == Class
        my_each { |v| return true if v.is_a?(pattern) }
      else
        my_each { |v| return true if v == pattern }
      end
    else
      my_each { |v| return true if v }
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given?
      my_each { |v| return false if yield(v) }
    elsif !pattern.nil?
      if pattern.is_a?(Regexp)
        my_each { |v| return false if pattern =~ v.to_s }
      elsif pattern.class == Class
        my_each { |v| return false if v.is_a?(pattern) }
      else
        my_each { |v| return false if v == pattern }
      end
    else
      my_each { |v| return false if v }
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

  def my_inject(*arg)
    acc, nxt, start, sym = nil, nil, nil, nil
    if arg.nil?
      acc = self[0]
      nxt = self[1]
      start = 1
    elsif arg.length == 2
      acc = arg[0]
      nxt = self[0]
      start = 0
      sym = arg[1]
    else
      if arg[0].is_a?(Integer)
        acc = arg[0]
        start = 0
        sym = nil
      else
        acc = self[0]
        start = 1
        sym = arg[0]
      end
    end

    if block_given?
      for i in start...self.size
        acc = yield(acc, nxt)
        nxt = self[i + 1]
      end
      acc
    else
      for i in start...self.size
        acc = acc.send(sym, nxt)
        nxt = self[i + 1]
      end
      acc
    end
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

p multiply_els([1, 2 ,3])