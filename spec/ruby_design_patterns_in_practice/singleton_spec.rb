require "spec_helper"
require "json"

# Provide a surrogate or placeholder for another object to control access to it.

RSpec.describe "Singleton design pattern" do

  context "Usage" do
    class TestSingleton

      def hero_instance
        RubyDesignPatternsInPractice::Singleton::HeroFactory.instance
      end

      def new_hero
        RubyDesignPatternsInPractice::Singleton::HeroFactory.new
      end

    end

    context "Instance methods" do
      before do
        @test_klass = TestSingleton.new
      end

      context "#hero_instance" do
        it "should get the hero instance" do
          expect(@test_klass.hero_instance).to be_kind_of(RubyDesignPatternsInPractice::Singleton::HeroFactory)
        end
        it "should be uniq" do
          expect(@test_klass.hero_instance == @test_klass.hero_instance).to eq(true)
        end
      end

      context "#new_hero" do
        it "should raise exception" do
          expect{@test_klass.new_hero}.to raise_error(NoMethodError)
        end
      end
    end
  end
end