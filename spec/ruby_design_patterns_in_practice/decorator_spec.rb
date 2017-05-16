require "spec_helper"
require "json"

# Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

RSpec.describe "Decorator design pattern" do

  context "Usage" do
    class TestDecorator
      attr_reader :item
      def initialize(item)
        @item = item
      end

      def decorate(decorator)
        decorator.new(@item)
      end
    end

    context "Instance methods" do
      context "#decorate" do
        before do
          @test_klass = TestDecorator.new(RubyDesignPatternsInPractice::Decorator::Item.new)
          @magic_item_decorator = RubyDesignPatternsInPractice::Decorator::MagicItemDecorator
          @masterpiece_item_decorator = RubyDesignPatternsInPractice::Decorator::MasterpieceItemDecorator
        end

        it "should decorate description with MagicItemDecorator" do
          expect(@test_klass.decorate(@magic_item_decorator).description).to eq("Item Magic")
        end

        it "should decorate description withMasterpieceItemDecorator" do
          expect(@test_klass.decorate(@masterpiece_item_decorator).description).to eq("Item Masterpiece")
        end

        it "should decorate price with MagicItemDecorator" do
          expect(@test_klass.decorate(@magic_item_decorator).price).to eq(30)
        end

        it "should decorate price withMasterpieceItemDecorator" do
          expect(@test_klass.decorate(@masterpiece_item_decorator).price).to eq(20)
        end

      end
    end
  end
end