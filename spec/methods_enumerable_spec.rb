require_relative  '../lib/methods_enumerable'

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
  it "returns true or false if all the element match with the criterion" do
    bool = ["ball","bat"].my_all?(String)
    expect(bool).to eql(true)   
  end
  it "returns boolean based on condition if any element matches with the condition" do
    bool = ["ball","bat"].my_any?(String)
    expect(bool).to eql(true)
  end
  it "returns boolean based on condition if none of the element matches with the condition" do
    bool = ["ball","bat"].my_none?(String)
    expect(bool).to eql(false)
  end
end