module ObjectDiff
  class PlainDiff
    def initialize(a, b)
      @a = a
      @b = b
    end

    def diff
      [@a, @b]
    end
  end
end


