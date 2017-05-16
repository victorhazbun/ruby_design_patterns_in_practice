module RubyDesignPatternsInPractice
  module Adapter
    class Hero
      attr_accessor :level, :exp, :quests

      def initialize
        @level = 1
        @exp = 0
        @quests = []
      end

      def take_quest(quest)
        @quests << (quest.hero = self)
      end

      def finish_quest(quest)
        quest.finish
        @quests.delete quest
      end
    end
  end
end