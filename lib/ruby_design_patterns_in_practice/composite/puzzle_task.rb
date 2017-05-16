module RubyDesignPatternsInPractice
  module Composite
    class PuzzleTask
      attr_reader :reward

      def initialize
        @reward = 200
      end
    end
  end
end