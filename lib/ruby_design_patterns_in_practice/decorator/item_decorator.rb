module RubyDesignPatternsInPractice
  module Decorator
    class ItemDecorator
      def initialize(item)
        @item = item
      end
      # this needs to be delegated with other efective way
      def use
        @item.use
      end
    end
  end
end
