require "spec_helper"
require "json"

# Define a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

RSpec.describe "Observer design pattern" do

  context "Usage" do
    class TestObserver
      attr_accessor :hero, :tile
      def initialize
        @hero = RubyDesignPatternsInPractice::Observer::Hero.new
        @tile = RubyDesignPatternsInPractice::Observer::Tile.new cursed: true
      end

      def play
        @hero.discover(@tile)
        @tile.activate_curse
      end

    end

    context "Instance methods" do
      before do
        @test_klass = TestObserver.new
      end

      context "#play" do
        it "should update hero health" do
          expect{@test_klass.play}.to change{@test_klass.hero.health}.from(10).to(6)
        end
        it "should update hero cursed state" do
          expect{@test_klass.play}.to change{@test_klass.hero.cursed?}.from(false).to(true)
        end
      end
    end
  end
end