module ObjectDiff
  class Comparator
    attr_reader :key

    def initialize(*raw_key)
      @raw_key = raw_key
      @diff = {}
    end

    def diff(a, b)
      {}.tap do |acc|
        comparisons.each_pair do |attr_name, comparator|
          attr_diff = comparator.diff(a.send(attr_name), b.send(attr_name))
          acc[attr_name] = attr_diff if attr_diff
        end
      end
    end

    private

    def comparator_for(key_item)
      comparator = key_item.delete(:comparator)
      comparator ||= AttrComparator.new unless key_item[:key]
      comparator ||= Comparator.new(*key_item[:key])
      comparator = CollectionComparator.new(key_item[:mapper], comparator) if key_item[:mapper]
      comparator
    end

    def normalized_key
      @raw_key.map do |raw_key_item|
        if raw_key_item.is_a?(Hash)
          raw_key_item
        else
          { :attribute => raw_key_item }
        end
      end
    end

    def comparisons
      normalized_key.each_with_object({}) do |key_item, acc|
        acc[key_item.delete(:attribute)] = comparator_for(key_item)
      end
    end
  end
end
