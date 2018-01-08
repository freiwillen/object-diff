module ObjectDiff
  class Comparator
    attr_reader :key

    def initialize(*key)
      @key = key
    end

    def diff(a, b)
      Hash.new.tap do |diff|
        key.each do |attr_key|
          if attr_key.is_a?(Symbol)
            diff_attr = self.attr_diff(a.send(attr_key), b.send(attr_key))
            diff[attr_key] = diff_attr if diff_attr
          elsif attr_key.is_a?(Hash)

            attr_name = attr_key[:attribute]
            a_attr = a.send(attr_name)
            b_attr = b.send(attr_name)
            diff[attr_name] = self.class.new(*attr_key[:key]).diff(a_attr, b_attr)
          end
        end

      end
    end

    def attr_diff(a, b)
      AttrComparator.new(a,b).diff
    end
  end
end
