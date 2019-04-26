require  'spec_helper'

describe Enumerable do
  it "loops through enumerable objects element" do
    res = []
    [1,2,3,4].my_each{|v| res.push(v + 1)}
    expect(res).to eql([2,3,4,5])  
  end
  it "loops through enumerable objects element with index" do
    res = []
    [1,2,3,4].my_each_with_index{|v,i| res.push(i)}
    expect(res).to eql([0,1,2,3])
  end
  it "retuens an array which selects the citerion " do
    res = [1,2,3,4].my_select(&:odd?)
    expect(res).to eql([1,3])  
  end
end