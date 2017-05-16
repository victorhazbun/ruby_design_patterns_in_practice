module RubyDesignPatternsInPractice
  module Proxy
    class Computer
      def initialize
        @queue = []
      end

      def add(command)
        @queue << command
      end

      def execute
        "executing commands"
      end
    end
  end
end
