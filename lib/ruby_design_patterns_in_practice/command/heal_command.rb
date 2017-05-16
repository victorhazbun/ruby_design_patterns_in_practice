module RubyDesignPatternsInPractice
  module Command
    class HealCommand
      def initialize(hero)
        @hero = hero
      end

      def execute
        @hero.health += 10
      end

      def unexecute
        @hero.health -= 10
      end
    end
  end
end