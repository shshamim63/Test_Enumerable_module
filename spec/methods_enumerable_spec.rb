require_relative  '../lib/methods_enumerable'

ARRAY_SIZE = 5
HIGHEST_VALUE = 9
LOWEST_VALUE = 0
describe Enumerable do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE..HIGHEST_VALUE) } }

  describe 'my_each' do 
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
end