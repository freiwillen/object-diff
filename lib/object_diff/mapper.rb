module ObjectDiff
  class Mapper
    attr_reader :key
    def initialize(*key)
      @key = key
    end

    def map(a, b)
      key_map_a = Hash.new.tap do |h|
        a.each do |element|
          h[key.map {|key_part| element.send(key_part) }] = element
        end
      end
      key_map_b = Hash.new.tap do |h|
        b.each do |element|
          h[key.map {|key_part| element.send(key_part) }] = element
        end
      end
      
      map_by_a = Hash.new.tap do |h|
        key_map_a.each_pair do |k, v|
          h[v] = key_map_b[k]
        end
      end
      
      map_by_b = Hash.new.tap do |h|
        key_map_b.each_pair do |k, v|
          h[v] = key_map_a[k]
        end
      end
      map_by_a.merge(map_by_b.invert)
    end
  end
end
