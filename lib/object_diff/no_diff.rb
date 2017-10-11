module ObjectDiff
  NoDiff = Struct.new(:a, :b) do
    def diff(*whatever); end
  end
end
