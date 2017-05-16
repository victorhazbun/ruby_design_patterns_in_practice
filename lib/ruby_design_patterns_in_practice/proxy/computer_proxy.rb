
require 'forwardable'
module RubyDesignPatternsInPractice
  module Proxy
    class ComputerProxy
      # Forwardable allows objects to run methods on behalf
      # of it's members, in this case the Computer object
      extend Forwardable

      # We delegate the ComputerProxy's use of
      # the Computer object's add method
      def_delegators :real_object, :add

      def initialize(hero)
        @hero = hero
      end

      def execute
        check_access
        real_object.execute
      end

      def check_access
        unless @hero.keywords.include?(:computer)
          raise "You have no access"
        end
      end

      def real_object
        @real_object ||= Computer.new
      end
    end
  end
end
