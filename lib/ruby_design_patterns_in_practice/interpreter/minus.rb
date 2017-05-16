module RubyDesignPatternsInPractice
  module Interpreter
    class Minus
      def initialize(first, second)
        @first = first
        @second = second
      end

      def execute
        index = @first.execute =~ /#{@second.execute}/
        second_index = index + @second.execute.length
        @first.execute[0,index] + @first.execute[second_index..-1]
      end
    end
  end
end