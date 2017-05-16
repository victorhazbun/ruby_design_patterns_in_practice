require "spec_helper"
require "json"

# Iterator helps you to iterate through a complex object using an iterator method.

RSpec.describe "Iterator design pattern" do

  context "Usage" do
    class TestIterator
      attr_accessor :family
      def initialize(surname)
        @surname = surname
        @family = RubyDesignPatternsInPractice::Iterator::Family.new surname
        @family.add_father("Robert")
        @family.add_mother("Susan")
        @family.add_child("Lucas", "M")
        @family.add_child("James", "M")
        @family.add_child("Rose", "F")
      end

      def update_family_name
        @family.each_member{ |member| member.name = "#{member.name} #{@surname}" }
      end
    end

    context "Instance methods" do
      before do
        @test_klass = TestIterator.new("Jackson")
      end
      it "should update the father name" do
        expect{ @test_klass.update_family_name }.to change{ @test_klass.family.father.name }.from("Robert").to("Robert Jackson")
      end
      it "should update the mother name" do
        expect{ @test_klass.update_family_name }.to change{ @test_klass.family.mother.name }.from("Susan").to("Susan Jackson")
      end
      it "should update the first child name" do
        expect{ @test_klass.update_family_name }.to change{ @test_klass.family.children[0].name }.from("Lucas").to("Lucas Jackson")
      end
      it "should update the second child name" do
        expect{ @test_klass.update_family_name }.to change{ @test_klass.family.children[1].name }.from("James").to("James Jackson")
      end
      it "should update the third child name" do
        expect{ @test_klass.update_family_name }.to change{ @test_klass.family.children[2].name }.from("Rose").to("Rose Jackson")
      end

    end
  end
end