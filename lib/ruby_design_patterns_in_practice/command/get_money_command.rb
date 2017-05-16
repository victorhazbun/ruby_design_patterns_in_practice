module RubyDesignPatternsInPractice
  module Command
    class GetMoneyCommand
      def initialize(hero)
        @hero = hero
      end

      def execute
        @hero.money += 10
      end

      def unexecute
        @hero.money -= 10
      end
    end
  end
end