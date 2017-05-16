module RubyDesignPatternsInPractice
  module Factory
    class Party
      attr_reader :members
      def initialize(factory)
        @members = []
        @factory = factory
      end

      def add_warriors(n)
        n.times{ @members << @factory.create_warrior }
      end

      def add_mages(n)
        n.times{ @members << @factory.create_mage }
      end
    end
  end
end