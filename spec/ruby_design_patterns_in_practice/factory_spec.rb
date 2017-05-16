require "spec_helper"
require "json"

# Define an interface for creating an object, but let subclasses decide which class to instantiate.

RSpec.describe "Factory design pattern" do

  context "Usage" do
    class TestFactory
      attr_reader :party
      def initialize
        @party = RubyDesignPatternsInPractice::Factory::Party.new(RubyDesignPatternsInPractice::Factory::HeroFactory.new)
      end

      def add_warriors(n)
        @party.add_warriors(n)
      end

      def add_mages(n)
        @party.add_mages(n)
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestFactory.new
        @test_klass.add_warriors(3)
        @test_klass.add_mages(6)
      end
      context "#add_warriors" do
        it "should change the members size" do
          expect{ @test_klass.add_warriors(11) }.to change{ @test_klass.party.members.size }.from(9).to(20)
        end
        it "should change members size of type Warrior" do
          expect{ @test_klass.add_warriors(1) }.to change{ @test_klass.party.members.count{ |member| member.class == RubyDesignPatternsInPractice::Factory::Warrior } }.from(3).to(4)
        end
      end
      context "#add_mages" do
        it "should change the members size" do
          expect{ @test_klass.add_mages(12) }.to change{ @test_klass.party.members.size }.from(9).to(21)
        end
        it "should change members size of type mage" do
          expect{ @test_klass.add_mages(1) }.to change{ @test_klass.party.members.count{ |member| member.class == RubyDesignPatternsInPractice::Factory::Mage } }.from(6).to(7)
        end
      end
    end
  end
end