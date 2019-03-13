module ObjectDiff
  module Diffable
    def self.included(base)
      base.extend(ClassMethods)
      base.include(InstanceMethods)
    end

    module ClassMethods
      def diff_by(*attributes)
        @comparator = Comparator.new(*attributes)
      end

      attr_reader :comparator
    end

    module InstanceMethods
      def diff(other)
        self.class.comparator.diff(self, other)
      end
    end
  end
end
