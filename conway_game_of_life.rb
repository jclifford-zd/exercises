require 'minitest/autorun'

class ConwayGame
  def generation matrix
    neighbour_counts = Array.new(matrix.length) { Array.new(matrix.first.length, 0) }
    result = matrix.clone

    # p matrix
    # p neighbour_counts
    # p result

    matrix.each_with_index do |arr, y|
      arr.each_with_index do |value, x|
        # p "Iterating: position:    y: #{y} x: #{x}"
        neighbour_counts[y][x] += matrix[y-1][x-1] if (x > 0 && y > 0)
        neighbour_counts[y][x] += matrix[y-1][x] if y > 0
        neighbour_counts[y][x] += matrix[y-1][x+1] if (y > 0 && x < arr.length - 1)
        neighbour_counts[y][x] += matrix[y][x-1] if x > 0
        neighbour_counts[y][x] += matrix[y][x+1] if (x < arr.length - 1)
        neighbour_counts[y][x] += matrix[y+1][x-1] if (y < matrix.length - 1 && x > 0)
        neighbour_counts[y][x] += matrix[y+1][x] if y < matrix.length - 1
        neighbour_counts[y][x] += matrix[y+1][x+1] if (y < matrix.length - 1 && x < arr.length - 1)
        # p "neighbour_counts[y][x]: #{neighbour_counts[y][x]}"
      end
    end
    # p "matrix:            #{matrix}"
    # p "neighbour_counts:  #{neighbour_counts}"

    matrix.each_with_index do |arr, y|
      arr.each_with_index do |value, x|
        if (matrix[y][x] == 1 &&
            (neighbour_counts[y][x] < 2 || neighbour_counts[y][x] > 3))
          result[y][x] = 0
        elsif (matrix[y][x] == 0 && neighbour_counts[y][x] == 3)
          result[y][x] = 1
        end
      end
    end
    # p "result:            #{result}"
    result
  end
end

class ConwayGameTest < Minitest::Test
  def setup
    @game = ConwayGame.new
  end

  def test_empty_input
    empty_in = []
    empty_out = []
    assert_equal empty_in, @game.generation(empty_out)
  end

  def test_blinker
    blinker_in = [[0, 1, 0], [0, 1, 0], [0, 1, 0]]
    blinker_out = [[0, 0, 0], [1, 1, 1], [0, 0, 0]]
    assert_equal blinker_out, @game.generation(blinker_in)
  end

  def test_asymmetric
    asym_in = [[1, 0, 1], [0, 1, 0]]
    asym_out = [[0, 1, 0], [0, 1, 0]]
    assert_equal asym_out, @game.generation(asym_in)
  end

  def test_pulsar
    pulsar =  [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,1,1,1,0,0,0,1,1,1,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,0,0,1,1,1,0,0,0,1,1,1,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,1,1,1,0,0,0,1,1,1,0,0,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,1,0,0,0,0,1,0,1,0,0,0,0,1,0],
               [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
               [0,0,0,1,1,1,0,0,0,1,1,1,0,0,0],
               [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
    pulsar_solution = [[0,0,0,0,1,0,0,0,0,0,1,0,0,0,0],
                       [0,0,0,0,1,0,0,0,0,0,1,0,0,0,0],
                       [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0],
                       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                       [1,1,1,0,0,1,1,0,1,1,0,0,1,1,1],
                       [0,0,1,0,1,0,1,0,1,0,1,0,1,0,0],
                       [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0],
                       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                       [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0],
                       [0,0,1,0,1,0,1,0,1,0,1,0,1,0,0],
                       [1,1,1,0,0,1,1,0,1,1,0,0,1,1,1],
                       [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                       [0,0,0,0,1,1,0,0,0,1,1,0,0,0,0],
                       [0,0,0,0,1,0,0,0,0,0,1,0,0,0,0],
                       [0,0,0,0,1,0,0,0,0,0,1,0,0,0,0]]
    assert_equal pulsar_solution, @game.generation(pulsar)
  end

  def test_glider
    glider =  [[1,0,0,0,0,0,0],
               [0,1,1,0,0,0,0],
               [1,1,0,0,0,0,0],
               [0,0,0,0,0,0,0],
               [0,0,0,0,0,0,0]]
    glider_solution = [[0,1,0,0,0,0,0],
                       [0,0,1,0,0,0,0],
                       [1,1,1,0,0,0,0],
                       [0,0,0,0,0,0,0],
                       [0,0,0,0,0,0,0]]
    assert_equal glider_solution, @game.generation(glider)
  end

  def test_glider_short
    glider_short = [[1,0,0],
                    [0,1,1],
                    [1,1,0],
                    [0,0,0]]
    glider_short_solution =[[0,1,0],
                            [0,0,1],
                            [1,1,1],
                            [0,0,0]]
    assert_equal glider_short_solution, @game.generation(glider_short)
  end
end
