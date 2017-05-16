require "spec_helper"
require "json"

RSpec.describe RubyDesignPatternsInPractice::Builder do

  context "Usage" do
    class TestKlass

      attr_accessor :builder, :board

      def initialize(width, height)
        @builder = RubyDesignPatternsInPractice::Builder::BoardBuilder.new width, height
        @board = builder.board
      end

      def add_tiles(n)
        builder.add_tiles(n)
      end

      def add_monsters(n)
        @builder.add_monsters(n)
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestKlass.new(10, 20)
      end

      context "#initialize" do
        it "board must be of type Board" do
          expect(@test_klass.board).to be_kind_of(RubyDesignPatternsInPractice::Builder::Board)
        end
        it "should change the board width" do
          expect(@test_klass.board.width).to eq(10)
        end

        it "should change the board height" do
          expect(@test_klass.board.height).to eq(20)
        end
      end

      context "#add_tiles" do
        before do
          @test_klass.add_tiles(3)
        end
        it "should update the board tiles size" do
          expect(@test_klass.board.tiles.size).to eq(3)
        end
      end

      context "#add_monsters" do
        before do
          @test_klass.add_monsters(4)
        end
        it "should update the board tiles size" do
          expect(@test_klass.board.monsters.size).to eq(4)
        end
      end

    end
  end
end