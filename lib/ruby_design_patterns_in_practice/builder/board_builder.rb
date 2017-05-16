module RubyDesignPatternsInPractice
  module Builder
    class BoardBuilder
      def initialize(width, height)
        @board = RubyDesignPatternsInPractice::Builder::Board.new
        @board.width = width
        @board.height = height
        @board.tiles = []
        @board.monsters = []
      end

      def add_tiles(n)
        n.times{ @board.tiles << RubyDesignPatternsInPractice::Builder::Tile.new }
      end

      def add_monsters(n)
        n.times{ @board.monsters << RubyDesignPatternsInPractice::Builder::Monster.new }
      end

      def board
        @board
      end
    end
  end
end