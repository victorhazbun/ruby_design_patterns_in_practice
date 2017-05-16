require "spec_helper"
require "json"

# Convert the interface of a class into another interface clients expect. Adapter lets classes work together that couldn't otherwise because of incompatible interfaces.

RSpec.describe "Adapter design pattern" do

  context "Usage" do
    class TestAdapter
      attr_reader :hero, :quest
      def initialize(difficulty)
        @difficulty = difficulty
        @hero = RubyDesignPatternsInPractice::Adapter::Hero.new
        @quest = RubyDesignPatternsInPractice::Adapter::Quest.new @difficulty
      end

      def complete_new_quest
        @hero.take_quest @quest
        @hero.finish_quest @quest
      end

      def complete_old_quest
        some_old_quest = RubyDesignPatternsInPractice::Adapter::OldQuest.new
        old_quest_adapted = RubyDesignPatternsInPractice::Adapter::QuestAdapter.new(some_old_quest, @difficulty)
        @hero.take_quest old_quest_adapted
        @hero.finish_quest old_quest_adapted
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestAdapter.new(5)
      end
      context "#complete_new_quest" do
        it "should update the hero exp" do
          expect { @test_klass.complete_new_quest }.to change{ @test_klass.hero.exp }.from(0).to(250)
        end
      end

      context "#complete_old_quest" do
        it "should update the hero exp" do
          expect { @test_klass.complete_old_quest }.to change{ @test_klass.hero.exp }.from(0).to(50)
        end
      end
    end
  end
end