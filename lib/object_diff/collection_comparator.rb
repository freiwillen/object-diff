module ObjectDiff
  class CollectionComparator
    def initialize(mapper, key)
      @mapper = mapper
      @key = key
    end

    def key
      @key || []
    end

    def diff(a, b)
      return if map(a,b).empty?
      {:added => [], :removed => [], :changed => {}}.tap do |h|
        map(a, b).each_pair do |pair|
          process_pair(pair, h)
        end
        h.delete(:added) if h[:added].empty?
        h.delete(:removed) if h[:removed].empty?
        h.delete(:changed) if h[:changed].empty?
      end
    end

    def map(a, b)
      @map ||= @mapper.map(a, b)
    end

    def process_pair(pair, h)
      h[:added] << pair.last && return if pair.first.nil?
      h[:removed] << pair.first && return if pair.last.nil?
      h[:changed][pair.first] = Comparator.new(*key).diff(*pair)
    end
  end
end
