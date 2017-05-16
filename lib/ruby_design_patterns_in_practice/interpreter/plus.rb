module RubyDesignPatternsInPractice
  module Interpreter
    class Plus
      def initialize(first, second)
        @first = first
        @second = second
      end

      def execute
        @first.execute + @second.execute
      end
    end
  end
end