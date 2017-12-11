module ObjectDiff
  class Comparator
    def initialize(a, b)
      @a = a
      @b = b
    end

    def diff_by(plain_key:[], complex_key:{})
      Hash.new.tap do |diff|
        plain_key.each do |attr_name|
          diff_attr = self.attr_diff(attr_name)
          diff[attr_name] = diff_attr if diff_attr
        end

        complex_key.each_pair do |attr_name, key|
          diff[attr_name] = self.class.new(@a.send(attr_name), @b.send(attr_name)).diff_by(plain_key: key)
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
