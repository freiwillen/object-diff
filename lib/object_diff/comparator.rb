module ObjectDiff
  class Comparator
    attr_reader :plain_key, :complex_key

    def initialize(plain_key:[], complex_key:{})
      @plain_key = plain_key
      @complex_key = complex_key
    end

    def diff(a, b)
      Hash.new.tap do |diff|
        plain_key.each do |attr_name|
          diff_attr = self.attr_diff(a.send(attr_name), b.send(attr_name))
          diff[attr_name] = diff_attr if diff_attr
        end

        complex_key.each_pair do |attr_name, key|
          diff[attr_name] = self.class.new(plain_key: key).diff(a.send(attr_name), b.send(attr_name))
        end
      end
    end

    def attr_diff(a, b)
      differ(a, b).new(a, b).diff
    end

    def differ(a, b)
      Caster.new(a, b).differ
    end
  end
end
