module RubyDesignPatternsInPractice
  module Iterator
    class Family
      attr_reader :father, :mother, :children
      def initialize(surname)
        @surname = surname
        @children = []
      end

      def add_father(name)
        @father = Ancestor.new name, "M"
      end

      def add_mother(name)
        @mother = Ancestor.new name, "F"
      end

      def add_child(name, gender)
        @children << Child.new(name, gender)
      end

      def each_member
        [@father, @mother, @children].flatten.each do |member|
          yield member
        end
      end
    end
  end
end