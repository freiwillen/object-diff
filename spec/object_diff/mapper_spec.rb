require 'spec_helper'

module ObjectDiff
  RSpec.describe Mapper do
    it "maps objects from 2 arrays by simple key" do
      a11 = OpenStruct.new(:id => 1, :attr1 => 5, :attr2 => 7)
      a12 = OpenStruct.new(:id => 2, :attr1 => 4, :attr2 => 3)
      a13 = OpenStruct.new(:id => 3, :attr1 => 4, :attr2 => 3)

      a = [a11, a12, a13]

      b11 = OpenStruct.new(:id => 1, :attr1 => 25, :attr2 => 17)
      b12 = OpenStruct.new(:id => 2, :attr1 => 8, :attr2 => 9)
      b14 = OpenStruct.new(:id => 4, :attr1 => 4, :attr2 => 3)

      b = [b11, b12, b14]

      mapper = Mapper.new(:id)

      expect(mapper.map(a, b)).to eq({
        a11 => b11,
        a12 => b12,
        a13 => nil,
        nil => b14
      })
    end
  end
end
