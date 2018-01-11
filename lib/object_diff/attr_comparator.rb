module ObjectDiff
  class AttrComparator
    def initialize(a, b)
      @a = a
      @b = b
    end

    def differ_class
      if @a == @b
        NoDiff
      elsif @a.is_a?(Array)
        ArrayDiff
      elsif @a.is_a?(Hash)
        HashDiff
      else
        PlainDiff
      end
    end

    def diff
      differ_class.new(@a,@b).diff
    end
  end
end

