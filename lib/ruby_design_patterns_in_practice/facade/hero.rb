module RubyDesignPatternsInPractice
  module Facade
    class Hero
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def join(level)
        puts "#{self.name} join #{level}\n"
      end

      def attack(enemy)
        puts "#{self.name} kick #{enemy}\n"
      end
    end
  end
end
