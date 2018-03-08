module ObjectDiff
  class AttrComparator
    def differ_class(a, b)
      if a == b
        NoDiff
      elsif a.is_a?(Array)
        ArrayDiff
      elsif a.is_a?(Hash)
        HashDiff
      else
        PlainDiff
      end
    end

    def diff(a, b)
      differ_class(a, b).new(a, b).diff
    end
  end
end

