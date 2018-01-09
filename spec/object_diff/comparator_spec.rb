require "spec_helper"
require "ostruct"

module ObjectDiff
  RSpec.describe Comparator do
    it "gets diff by plain attrs key" do
      a = OpenStruct.new(:a => 1, :b => 2, :c => 3)
      b = OpenStruct.new(:a => 2, :b => 2, :c => 7)

      comparator = Comparator.new(:a, :b, :c)

      expect(comparator.diff(a, b)).to eq({
        :a => [1, 2],
        :c => [3, 7]
      })
    end

    it "considers values of similar value but different kind as different" do
      a = OpenStruct.new(:a => 1, :b => "2")
      b = OpenStruct.new(:a => "1", :b => 2)
      comparator = Comparator.new(:a, :b, :c)

      expect(comparator.diff(a, b)).to eq({
        :a => [1, "1"],
        :b => ["2", 2]
      })
    end

    it "gets diff by array" do
      a = OpenStruct.new(:a => 2, :b => [1, 2, 3])
      b = OpenStruct.new(:a => 2, :b => [2, 3, 4, 5])
      comparator = Comparator.new(:a, :b)

      expect(comparator.diff(a, b)).to eq({
        :b => {
          :added => [4, 5],
          :removed => [1]
        }
      })
    end
    it 'gets diff by hash' do
      a = OpenStruct.new(:a => 2, :b => {
        :a1 => 10,
        :b1 => {:b2 => 15},
        :c1 => 12,
        :d1 => 12,
      })
      b = OpenStruct.new(:a => 2, :b => {
        :a1 => 5,
        :b1 => {:b2 => 20},
        :d1 => 12,
      })
      comparator = Comparator.new(:a, :b)

      expect(comparator.diff(a, b)).to eq({
        :b => {
          :a1 => [10, 5],
          :b1 => {
            :b2 => [15, 20]
          },
          :c1 => [12, nil]
        }
      })
    end
    it 'gets diff of attr by a complex key' do
      a1 = OpenStruct.new(:a1 => 10, :b2 => 12)
      a = OpenStruct.new(:a => a1)
      b1 = OpenStruct.new(:a1 => 11, :b2 => 12)
      b = OpenStruct.new(:a => b1)

      comparator = Comparator.new({:attribute => :a, :key => [:a1, :b2]})

      expect(comparator.diff(a, b)).to eq({
        :a => {:a1 => [10, 11]}
      })
    end
    it "gets diff of array of complex objects" do
      a11 = OpenStruct.new(:id => 1, :attr1 => 5, :attr2 => 7)
      a12 = OpenStruct.new(:id => 2, :attr1 => 4, :attr2 => 3)
      a13 = OpenStruct.new(:id => 3, :attr1 => 4, :attr2 => 3)

      a = OpenStruct.new(:a1 => [a11, a12, a13])

      b11 = OpenStruct.new(:id => 1, :attr1 => 25, :attr2 => 17)
      b12 = OpenStruct.new(:id => 2, :attr1 => 8, :attr2 => 9)
      b14 = OpenStruct.new(:id => 3, :attr1 => 4, :attr2 => 3)

      b = OpenStruct.new(:a1 => [b11, b12, b14])

      comparator = Comparator.new({:attribute => :a1, :mapper => Mapper.new(:id)})

      expect(comparator.diff(a, b)).to eq({
        :a => {
          :a1 => {
            :added => [b14],
            :removed => [a13],
            :changed => {
              b11 => { :attr1 => [5, 25], :attr2 => [7, 17] },
              b12 => { :attr1 => [4, 8], :attr2 => [3, 9] },
            }
          }
        }
      })
    end
  end
end
