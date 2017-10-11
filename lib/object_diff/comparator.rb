module ObjectDiff
  class Comparator
    def initialize(a, b)
      @a = a
      @b = b
    end

    def diff_by(*attr_names)
      Hash.new.tap do |diff|
        attr_names.each do |attr_name|
          diff_attr = self.attr_diff(attr_name)
          diff[attr_name] = diff_attr if diff_attr
        end
      end
    end

    def attr_diff(attr_name)
      differ(attr_name).new(@a.send(attr_name), @b.send(attr_name)).diff
    end

    def differ(attr_name)
      Caster.new(@a, @b).differ(attr_name)
    end

    def hash_diff(a, b)
      HashDiff.new(a,b).diff
    end
  end
end
