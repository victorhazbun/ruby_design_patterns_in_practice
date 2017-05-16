module RubyDesignPatternsInPractice
  module Proxy
    class Hero
      attr_accessor :keywords

      def initialize
        @keywords = []
      end
    end
  end
end