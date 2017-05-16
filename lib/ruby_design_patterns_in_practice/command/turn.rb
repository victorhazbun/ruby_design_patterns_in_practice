module RubyDesignPatternsInPractice
  module Command
    class Turn
      def initialize
        @commands = []
      end

      def run_command(command)
        command.execute
        @commands << command
      end

      def undo_command
        @commands.pop.unexecute if @commands.any?
      end
    end
  end
end