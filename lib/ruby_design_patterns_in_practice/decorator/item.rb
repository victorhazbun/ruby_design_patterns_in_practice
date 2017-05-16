module RubyDesignPatternsInPractice
  module Decorator
    class Item
      attr_reader :price, :description
      def initialize
        @price = 10
        @description = "Item "
      end

      def use
        "do something"
      end
    end
  end
end