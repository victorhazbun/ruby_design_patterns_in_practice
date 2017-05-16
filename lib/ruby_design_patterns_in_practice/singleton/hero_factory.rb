module RubyDesignPatternsInPractice
  module Singleton
    class HeroFactory
      @@instance = nil

      def self.instance
        @@instance ||= HeroFactory.send(:new)
      end

      private_class_method :new
    end
  end
end