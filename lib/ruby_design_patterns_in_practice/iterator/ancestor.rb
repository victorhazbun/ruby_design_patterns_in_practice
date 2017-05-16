module RubyDesignPatternsInPractice
  module Iterator
    class Ancestor
      attr_accessor :name

      def initialize(name, gender)
        @name = name
        @gender = gender
      end
    end
  end
end