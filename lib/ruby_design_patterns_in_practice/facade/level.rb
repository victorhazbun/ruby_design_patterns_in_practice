module RubyDesignPatternsInPractice
  module Facade
    class Level
      attr_reader :stage

      def initialize(stage)
        @stage = stage
      end

      def to_s
        stage
      end
    end
  end
end