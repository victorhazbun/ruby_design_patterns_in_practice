module RubyDesignPatternsInPractice
  module Factory
    class HeroFactory
      def create_warrior
        Warrior.new
      end

      def create_mage
        Mage.new
      end
    end
  end
end