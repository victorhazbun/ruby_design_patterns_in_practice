require "spec_helper"
require "json"

# The goal of the Facade Pattern is to provide a unified interface to a set of interfaces in a subsystem. This means you'd just have some object that can send back other objects.

RSpec.describe "Decorator design pattern" do

  context "Usage" do
    class TestFacade
      attr_reader :game_facade
      def initialize
        @game_facade = RubyDesignPatternsInPractice::Facade::GameFacade.new
      end

      def play
        @game_facade.start_game
      end
    end

    context "Class methods" do
      context "#play" do
        before do
          @test_klass = TestFacade.new
        end
        it "should call hero#join" do
          expect(@test_klass.game_facade.hero).to receive(:join)
          @test_klass.play
        end
        it "should call hero#attack" do
          expect(@test_klass.game_facade.hero).to receive(:attack)
          @test_klass.play
        end
        it "should call enemy#dead" do
          expect(@test_klass.game_facade.enemy).to receive(:dead)
          @test_klass.play
        end
      end
    end
  end
end