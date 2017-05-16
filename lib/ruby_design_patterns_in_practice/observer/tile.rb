module RubyDesignPatternsInPractice
  module Observer
    class Tile
      include Observable

      def initialize(attrs = {})
        super
        @cursed = attrs.fetch(:cursed, false)
      end

      def cursed?
        @cursed
      end

      def activate_curse
        notify_observers
      end
    end
  end
end
