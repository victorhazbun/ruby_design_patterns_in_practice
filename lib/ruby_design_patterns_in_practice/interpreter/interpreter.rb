module RubyDesignPatternsInPractice
  module Interpreter
    class Interpreter
      def self.parse(input)
        @waiting_second_word = false
        words = []
        operations = []
        input.split.each_with_index do |value|
          if value =~ /^[^+-].*/ && !@waiting_second_word
            words << Word.new(value)
          else
            if symbol = operations.pop()
              first = words.size > 1 ? Word.new(words.map(&:execute).join(" ")) :
                words.pop
              second = Word.new(value)
              case symbol
              when /\A\+/
                words << Word.new(Plus.new(first, second).execute)
              when /\A\-/
                words << Word.new(Minus.new(first, second).execute)
              end
              @waiting_second_word = false
            else
              @waiting_second_word = true
              operations << value
            end
          end
        end
        words.pop.execute
      end
    end
  end
end