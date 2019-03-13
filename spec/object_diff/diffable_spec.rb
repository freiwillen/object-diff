require "spec_helper"

module ObjectDiff
  RSpec.describe Diffable do
    it 'makes objects diffable by attrs' do
      diffable_class = Class.new do
        include Diffable

        diff_by :a, :b

        def initialize(a, b, c)
          @a = a
          @b = b
          @c = c
        end

        attr_reader :a, :b, :c
      end

      a = diffable_class.new(1, 2, 3)
      b = diffable_class.new(4, 5, 6)

      expect(a.diff(b)).to eq({
        :a => [1, 4],
        :b => [2, 5]
      })


    end
  end
end

