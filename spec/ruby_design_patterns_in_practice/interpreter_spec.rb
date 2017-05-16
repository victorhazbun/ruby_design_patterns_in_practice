require "spec_helper"
require "json"

# This pattern provides an interpreter to deal with an abstract language. Using classes we can understand the inputs for parse them.

RSpec.describe "Interpreter design pattern" do

  context "Usage" do
    class TestInterpreter
      def self.parse(input)
        RubyDesignPatternsInPractice::Interpreter::Interpreter.parse(input)
      end
    end

    context "Class methods" do
      it "should parse the plus symbols" do
        expect(TestInterpreter.parse("NA + NA + NA + BATMAN")).to eq("NANANABATMAN")
      end

      it "should parse minus symbols" do
        expect(TestInterpreter.parse("you know nothing Jon Snow - nothing")).to eq("you know  Jon Snow")
      end

      it "should parse plus and minus symbols in the same input" do
        expect(TestInterpreter.parse("hello + world - llowo")).to eq("herld")
      end
    end
  end
end