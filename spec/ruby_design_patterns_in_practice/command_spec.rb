require "spec_helper"
require "json"

# Encapsulate a request as an object, thereby letting you parameterize clients with different requests, queue or log requests, and support undoable operations.

RSpec.describe "Command design pattern" do

  context "Usage" do
    class TestCommand
      attr_reader :hero
      def initialize
        @hero = RubyDesignPatternsInPractice::Command::Hero.new
        @turn = RubyDesignPatternsInPractice::Command::Turn.new
        @get_money = RubyDesignPatternsInPractice::Command::GetMoneyCommand.new @hero
        @get_heal = RubyDesignPatternsInPractice::Command::HealCommand.new @hero
      end

      def get_heal
        @turn.run_command(@get_heal)
      end

      def get_money
        @turn.run_command(@get_money)
      end

      def undo_last_action
        @turn.undo_command
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestCommand.new
      end

      context "#get_heal" do
        it "should change the hero health" do
          expect { @test_klass.get_heal }.to change{ @test_klass.hero.health }.from(100).to(110)
        end
      end

      context "#get_money" do
        it "should change the hero money" do
          expect { @test_klass.get_money }.to change{ @test_klass.hero.money }.from(0).to(10)
        end
      end

      context "#undo_last_action" do
        before do
          @test_klass.get_money
        end
        it "should change the hero money to how it was before" do
          expect { @test_klass.undo_last_action }.to change{ @test_klass.hero.money }.from(10).to(0)
        end
      end

    end
  end
end