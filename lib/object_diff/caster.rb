module ObjectDiff
  class Caster
    def initialize(a, b)
      @a = a
      @b = b
    end

    def differ(attr_name)
      if @a.send(attr_name) == @b.send(attr_name)
        NoDiff
      elsif @a.send(attr_name).is_a?(Array)
        ArrayDiff
      elsif @a.send(attr_name).is_a?(Hash)
        HashDiff
      else
        PlainDiff
      end
    end
  end
end
