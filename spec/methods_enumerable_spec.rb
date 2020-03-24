require 'rspec'
require_relative  '../lib/methods_enumerable'

ARRAY_SIZE = 100
HIGHEST_VALUE = 9
LOWEST_VALUE = 0
describe Enumerable do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE..HIGHEST_VALUE) } }
  let(:range) { Range.new(LOWEST_VALUE + 1, HIGHEST_VALUE) }
  let(:words) { %w[ruby python c++ c javascript html5 css3] }
  let(:true_array) { [1, 'demo', true, 22.5, [1, 2, 3]] }
  let(:false_array) { [false, nil, false] }
  describe '#my_each' do 
    it 'it returns an enumarator if no block is given' do
      expect(array.my_each).to be_an(Enumerator)  
    end

    it 'loops through each element in the array and return self' do
      expect(array.my_each { |val| val }).to eq(array.each { |val| val })
    end

    it 'loops through each element and provies output besed on block' do
      my_each_output = 0
      array.my_each { |num| my_each_output += num }
      each_output = 0
      array.each { |num| each_output += num }
      expect(my_each_output).to eq(each_output)
    end
    it 'calls the given block once for each element in self' do
      each_output = ''
      block = proc { |num| each_output += num.to_s}
      array.my_each(&block)
      my_each_output = each_output.dup
      each_output= ''
      array.each(&block)
      expect(my_each_output).to eq(each_output)
    end
  end

  describe '#my_each_with_index' do
    it 'it returns an enumarator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)  
    end

    it 'loops through each element and provies output besed on provided block' do
      my_each_output = 0
      array.my_each_with_index { |val, idx| my_each_output += (val + idx) }
      each_output = 0
      array.each_with_index { |val, idx| each_output += (val + idx) }
      expect(my_each_output).to eq(each_output)
    end

    it 'loops through each element in the array and return self' do
      expect(array.my_each_with_index { |val, idx| val + idx }).to eq(array.each_with_index { |val, idx| val + idx })
    end

    it 'calls the given block once for each element in self' do
      each_output = ''
      block = proc { |val, idx| each_output += "#{val}: #{idx}\n"}
      array.my_each_with_index(&block)
      my_each_output = each_output.dup
      each_output= ''
      array.each_with_index(&block)
      expect(my_each_output).to eq(each_output)
    end
  end

  describe '#my_select' do
    it 'return an enumerator if no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end

    it 'returns an array containing the items for which block return a true value' do
      block = proc { |val| val % 3 == 0 }
      string_block = proc { |word| word.length > 3 }
      expect(array.my_select(&block)).to eql(array.select(&block))
      expect(range.my_select(&block)).to eql(range.select(&block))
      expect(words.my_select(&string_block)).to eql(words.select(&string_block))
    end
  end

  describe '#my_all?' do
    it 'return true if none of the item in the collection is false/nil' do
      expect(true_array.my_all?).to eql(true)
      expect(false_array.my_all?).to eql(false)
    end
    context 'When a block us given' do
      it 'return true if the block never returns false' do
        block = proc { |val| val > 0 }
        expect(range.my_all?(&block)).to eql(true)
        expect(range.my_all?(&block)).to eql(range.all?(&block))
      end
    end
    context 'when a pattern is supplied' do
      it 'when a class is given returns true if all the element are from the same class' do
        expect(array.my_all?(Integer)).to eql(array.all?(Integer))
      end

      it 'when a Regex is passed as an argument return true if all the items matches with the regex' do
        expect(words.my_all?(/d/)).to eql(false)
        expect(words.my_all?(/d/)).to eql(words.all?(/d/))
      end
      it 'when a pattern other than Regex or a Class is given return true if all the items match with it.' do
        expect(words.my_all?(/d/)).to eql(false)
        expect(words.my_all?(/d/)).to eql(words.all?(/d/))
      end
    end
  end
end
