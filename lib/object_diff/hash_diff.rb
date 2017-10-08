module ObjectDiff
  class HashDiff
    attr_reader :a, :b

    def initialize(a, b)
      @a = a
      @b = b
    end

    def keys
      @a.keys | @b.keys
    end

    def diff
      keys.inject({}) do |diff, key|
        key_diff(key, diff)
      end
    end

    def key_diff(key, diff)
      return diff if a[key] == b[key]
      diff[key] = if a[key].is_a?(Hash) && b[key].is_a?(Hash)
        HashDiff.new(a[key], b[key]).diff
      else
        [a[key], b[key]]
      end
      diff
    end
  end
end
