require "spec_helper"
require "json"

# Composition over inheritance. Compose objects into tree structures to represent part-whole hierarchies.

RSpec.describe "Composite design pattern" do

  context "Usage" do

    class TestComposite
      def add_task(quest, task)
        quest << task
      end

      def add_quest(megaquest, quest)
        megaquest << quest
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestComposite.new
        @quest1 = RubyDesignPatternsInPractice::Composite::Quest.new
        @monster_task = RubyDesignPatternsInPractice::Composite::MonsterTask.new
        @puzzle_task = RubyDesignPatternsInPractice::Composite::PuzzleTask.new
      end

      context "#do_task" do
        it "should change the quest reward" do
          expect{@test_klass.add_task(@quest1, @monster_task)
            @test_klass.add_task(@quest1, @puzzle_task)}.to change{ @quest1.reward }.from(0).to(300)
        end
      end

      context "#do_mega_quest" do
        before do
          @test_klass.add_task(@quest1, @monster_task)
          @test_klass.add_task(@quest1, @puzzle_task)
          @quest2 = RubyDesignPatternsInPractice::Composite::Quest.new
          @test_klass.add_task(@quest2, @monster_task)
          @test_klass.add_task(@quest2, @puzzle_task)
          @megaquest = RubyDesignPatternsInPractice::Composite::MegaQuest.new
        end
        it "should change the megaquest reward" do
          expect{@test_klass.add_quest(@megaquest, @quest1)
            @test_klass.add_quest(@megaquest, @quest2)}.to change{ @megaquest.reward }.from(0).to(600)
        end
      end

    end
  end
end