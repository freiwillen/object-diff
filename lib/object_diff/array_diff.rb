module ObjectDiff
  class ArrayDiff
    def initialize(a, b)
      @a = a
      @b = b
    end

    def diff
      Hash.new.tap do |h|
        h[:added] = added if added.any?
        h[:removed] = removed if removed.any?
      end
    end

    def added
      @b - @a
    end

    def removed
      @a - @b
    end
  end
end

