module RubyDesignPatternsInPractice
  module Decorator
    class MasterpieceItemDecorator < ItemDecorator
      def price
        @item.price * 2
      end

      def description
        @item.description + "Masterpiece"
      end
    end
  end
end