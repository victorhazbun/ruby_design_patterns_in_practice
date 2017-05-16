module RubyDesignPatternsInPractice
  module Adapter
    class Quest
      attr_accessor :difficulty, :hero

      def initialize(difficulty)
        @difficulty = difficulty
        @hero = nil
      end

      def finish
        @hero.exp += calculate_experience
      end

      def calculate_experience
        @difficulty * 50 / @hero.level
      end
    end
  end
end