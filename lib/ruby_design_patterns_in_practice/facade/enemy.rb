module RubyDesignPatternsInPractice
  module Facade
    class Enemy
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def dead(hero)
        puts "#{self.name} killed by #{hero}"
      end
    end
  end
end