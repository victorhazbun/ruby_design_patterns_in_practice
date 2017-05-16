module RubyDesignPatternsInPractice
  module Adapter
    class OldQuest
      attr_accessor :hero, :difficulty, :experience

      def initialize
        @difficulty = 3
        @experience = 10
      end

      def done
        difficulty * experience
      end
    end
  end
end