module RubyDesignPatternsInPractice
  module Command
    class Hero
      attr_accessor :money, :health

      def initialize
        @money = 0
        @health = 100
      end
    end
  end
end