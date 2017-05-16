require "spec_helper"
require "json"

# Provide a surrogate or placeholder for another object to control access to it.

RSpec.describe "Proxy design pattern" do

  context "Usage" do
    class TestProxy
      attr_accessor :hero
      def initialize
        @hero = RubyDesignPatternsInPractice::Proxy::Hero.new
        @proxy = RubyDesignPatternsInPractice::Proxy::ComputerProxy.new(@hero)
        @proxy.add("some command")
      end

      def add_keywords(keyword)
        @hero.keywords << keyword
      end

      def execute
        @proxy.execute
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestProxy.new
      end

      context "execute without adding keywords" do
        it "should raise exception" do
          expect{@test_klass.execute}.to raise_error(Exception, "You have no access")
        end
      end

      context "execute with keywords" do
        before do
          @test_klass.add_keywords(:computer)
        end

        it "should not raise exception" do
          expect{@test_klass.execute}.not_to raise_error
        end

        it "should return something" do
          expect(@test_klass.execute).to eq("executing commands")
        end
      end
    end
  end
end