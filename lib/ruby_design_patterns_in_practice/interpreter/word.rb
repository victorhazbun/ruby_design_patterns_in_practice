module RubyDesignPatternsInPractice
  module Interpreter
    class Word
      def initialize(value)
        @value = value
      end

      def execute
        @value
      end
    end
  end
end