module RubyDesignPatternsInPractice
  module Composite
    class CompositeQuest
      def initialize
        @tasks = []
      end

      def <<(task)
        @tasks << task
      end

      def reward
        @tasks.inject(0){ |sum, task| sum += task.reward }
      end
    end
  end
end