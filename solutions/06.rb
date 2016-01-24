module TurtleGraphics
  class Turtle
    attr_accessor :canvas

    ORIENTATIONS = [:left, :up, :right, :down]

    def initialize(rows, columns)
      @canvas = Array.new(rows) { |row| Array.new(columns) { |column| 0 } }
      @orientation = :right
      @turtle_position = spawn_at
      @canvas[@turtle_position[:row]][@turtle_position[:column]] += 1
    end

    def draw(special_way = nil, &block)
      self.instance_exec &block

      special_way ? special_way.draw(@canvas) : @canvas
    end

    def move
      case @orientation
      when :right then @turtle_position[:column] += 1
      when :left then @turtle_position[:column] -= 1
      when :up then @turtle_position[:row] -= 1
      when :down then @turtle_position[:row] += 1
      end

      transfer_turtle
      @canvas[@turtle_position[:row]][@turtle_position[:column]] += 1
    end

    def turn_left
      @orientation = ORIENTATIONS[ORIENTATIONS.index(@orientation) - 1]
    end

    def turn_right
      @orientation = ORIENTATIONS[ORIENTATIONS.index(@orientation) + 1]
    end

    def spawn_at(row = 0, column = 0)
      {row: row, column: column}
    end

    def look(orientation)
      @orientation = orientation
    end

    private

    def transfer_turtle
      row = @turtle_position[:row]
      column = @turtle_position[:column]
      case
        when row >= @canvas.size then @turtle_position[:row] == 0
        when row < 0 then @turtle_position[:row] == @canvas.size - 1
        when column >= @canvas.size then @turtle_position[:column] == 0
        when column < 0 then @turtle_position[:column] == @canvas.size - 1
      end
    end
  end

  module Canvas
    class ASCII
      def initialize(*symbols)
        @symbols = symbols.flatten
      end

      def draw(matrix)
      end
    end
  end
end
