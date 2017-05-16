module RubyDesignPatternsInPractice
  module Decorator
    class MagicItemDecorator < ItemDecorator
      def price
        @item.price * 3
      end

      def description
        @item.description + "Magic"
      end
    end
  end
end