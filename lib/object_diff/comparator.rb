module ObjectDiff
  class Comparator
    attr_reader :key

    def initialize(*raw_key)
      @raw_key = raw_key
    end

    def diff(a, b)
      Hash.new.tap do |diff|
        key.each do |key_item|
          if key_item[:key].nil? && key_item[:mapper].nil?
            diff_attr = self.simple_attr_diff(key_item, a, b)
            diff[key_item[:attribute]] = diff_attr if diff_attr
          elsif key_item[:mapper]
            diff[key_item[:attribute]] = collection_attr_diff(key_item, a, b)
          else
            diff[key_item[:attribute]] = object_attr_diff(key_item, a, b)
          end
        end

      end
    end

    def key
      @raw_key.map do |raw_key_item|
        if raw_key_item.is_a?(Hash)
          raw_key_item
        else
          { :attribute => raw_key_item }
        end
      end
    end

=begin
simple
object
collection(array of objects)
=end

    def object_attr_diff(attr_details, a, b)
      attr_name = attr_details[:attribute]
      a_attr = a.send(attr_name)
      b_attr = b.send(attr_name)
      key = attr_details[:key]
      self.class.new(*key).diff(a_attr, b_attr)
    end

    def collection_attr_diff(attr_details, a, b)
      attr_name = attr_details[:attribute]
      a_attr = a.send(attr_name)
      b_attr = b.send(attr_name)
      map = attr_details[:mapper].map(a_attr, b_attr)
      if map.any?
        diff[attr_name] = {}.tap do |h|
          map.each_pair do |element_a, element_b|
            (h[:added] ||= []) << element_b if element_a.nil?
            (h[:removed] ||= []) << element_a if element_b.nil?
            (h[:changed] ||= {})[element_a] = self.class.new(*attr_key[:key]).diff(element_a, element_b) if element_a && element_b
          end
        end
      end
    end

    def simple_differ_class(a, b)
      if a == b
        NoDiff
      elsif a.is_a?(Array)
        ArrayDiff
      elsif a.is_a?(Hash)
        HashDiff
      else
        PlainDiff
      end
    end

    def simple_attr_diff(attr_details, a, b)
      attr_name = attr_details[:attribute]
      a_attr = a.send(attr_name)
      b_attr = b.send(attr_name)
      simple_differ_class(a_attr, b_attr).new(a_attr, b_attr).diff
    end

    def attr_diff(a, b)
      AttrComparator.new(a,b).diff
    end
  end
end
