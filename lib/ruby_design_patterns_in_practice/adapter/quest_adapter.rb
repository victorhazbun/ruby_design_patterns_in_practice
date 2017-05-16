module RubyDesignPatternsInPractice
  module Adapter
    class QuestAdapter
      attr_accessor :hero

      def initialize(old_quest, difficulty)
        @old_quest = old_quest
        @old_quest.difficulty = difficulty
        @hero = nil
      end

      def finish
        @hero.exp += @old_quest.done
      end
    end
  end
end