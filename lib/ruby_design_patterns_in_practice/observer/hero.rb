module RubyDesignPatternsInPractice
  module Observer
    class Hero
      attr_reader :health

      def initialize
        @cursed = false
        @health = 10
      end

      def damage(hit)
        @health -= hit
      end

      def cursed?
        @cursed
      end

      def discover(tile)
        if tile.cursed?
          @cursed = true
          tile.add_observer(self)
        end
      end

      def update
        damage(4)
      end
    end
  end
end