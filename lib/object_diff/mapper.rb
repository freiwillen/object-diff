module ObjectDiff
  class Mapper
    attr_reader :key
    def initialize(*key)
      @key = key
    end

    def map(a, b)
      key_map_a = key_map(a)
      key_map_b = key_map(b)
      
      map_by_a = map_pair(key_map_a, key_map_b)
      map_by_b = map_pair(key_map_b, key_map_a)

      map_by_a.merge(map_by_b.invert)
    end

    private

    def key_map(array)
      Hash.new.tap do |h|
        array.each do |element|
          h[ key_for(element) ] = element
        end
      end
    end

    def key_for(element)
      key.map {|key_part| element.send(key_part) }
    end

    def map_pair(primary, secondary)
      Hash.new.tap do |h|
        primary.each_pair do |k, v|
          h[v] = secondary[k]
        end
      end
    end
  end
end
