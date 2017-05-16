module RubyDesignPatternsInPractice
  module Composite
    class MonsterTask
      attr_reader :reward

      def initialize
        @reward = 100
      end
    end
  end
end