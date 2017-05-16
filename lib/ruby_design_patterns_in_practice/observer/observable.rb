module RubyDesignPatternsInPractice
  module Observer
    module Observable
      attr_reader :observers

      def initialize(attrs = {})
        @observers = []
      end

      def add_observer(observer)
        @observers << observer
      end

      def notify_observers
        @observers.each{ |observer| observer.update }
      end
    end
  end
end