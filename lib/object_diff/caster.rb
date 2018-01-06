module ObjectDiff
  class Caster
    def initialize(a, b)
      @a = a
      @b = b
    end

    def differ
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
  end
end
