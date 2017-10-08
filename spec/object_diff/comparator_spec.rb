require "spec_helper"
require 'ostruct'

module ObjectDiff
  RSpec.describe Comparator do
    it "gets diff by plain attrs key" do
      a = OpenStruct.new(:a => 1, :b => 2, :c => 3)
      b = OpenStruct.new(:a => 2, :b => 2, :c => 7)
      comparator = Comparator.new(a, b)

      expect(comparator.diff_by(:a, :b, :c)).to eq({
        :a => [1, 2],
        :c => [3, 7]
      })
    end

    it "gets diff by array" do
      a = OpenStruct.new(:a => 2, :b => [1, 2, 3])
      b = OpenStruct.new(:a => 2, :b => [2, 3, 4, 5])
      comparator = Comparator.new(a, b)

      expect(comparator.diff_by(:a, :b)).to eq({
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
      comparator = Comparator.new(a, b)

      expect(comparator.diff_by(:a, :b)).to eq({
        :b => {
          :a1 => [10, 5],
          :b1 => {
            :b2 => [15, 20]
          },
          :c1 => [12, nil]
        }
      })
    end
  end
end
