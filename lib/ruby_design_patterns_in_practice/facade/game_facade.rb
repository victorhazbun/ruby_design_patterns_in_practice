module RubyDesignPatternsInPractice
  module Facade
    class GameFacade
      attr_reader :hero, :enemy, :level

      def initialize
        @hero  = Hero.new('Sonic')
        @enemy = Enemy.new('Eggman')
        @level = Level.new('Green Hill')
      end

      def start_game
        hero.join(level)
        hero.attack(enemy.name)
        enemy.dead(hero.name)
      end
    end
  end
end