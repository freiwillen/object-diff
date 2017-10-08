module ObjectDiff
  class Comparator
    def initialize(a, b)
      @a = a
      @b = b
    end

    def diff_by(*attr_names)
      Hash.new.tap do |diff|
        attr_names.each do |attr_name|
          diff_attr = self. attr_diff(attr_name)
          diff[attr_name] = diff_attr if diff_attr
        end
      end
    end

    def attr_diff(attr_name)
      if @a.send(attr_name) != @b.send(attr_name)
        if @a.send(attr_name).is_a?(Array)
          ArrayDiff.new(@a.send(attr_name), @b.send(attr_name)).diff
        elsif @a.send(attr_name).is_a?(Hash)
          HashDiff.new(@a.send(attr_name), @b.send(attr_name)).diff
        else
          PlainDiff.new(@a.send(attr_name), @b.send(attr_name)).diff
        end
      end
    end

    def hash_diff(a, b)
      HashDiff.new(a,b).diff
    end
  end
end
