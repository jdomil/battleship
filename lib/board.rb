# frozen_string_literal: true

# Class for battleships game board
class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n) { Array.new(n, :N) }
    @size = n * n
  end

  def [](array)
    @grid[array[0]][array[1]]
  end

  def []=(position, value)
    @grid[position[0]][position[1]] = value
  end

  def num_ships
    counter = 0
    @grid.each do |subarr|
      subarr.each do |ele|
        counter += 1 if ele == :S
      end
    end
    counter
  end

  def attack(position)
    if self[position] == :S
      self[position] = :H
      puts 'You sunk my battleship!'
      true
    else
      self[position] = :X
      false
    end
  end

  def place_random_ships
    ships = (size * 0.25).to_i
    n = Math.sqrt(size)
    row = Random.rand(n).to_i
    column = Random.rand(n).to_i
    position = [row, column]

    ships.times do
      while self[position] == :S
        row = Random.rand(n).to_i
        column = Random.rand(n).to_i
        position = [row, column]
      end
      self[position] = :S
    end
  end

  def hidden_ships_grid
    hidden_array = @grid.map do |subarray|
      subarray.map do |cell|
        cell == :S ? cell = :N : cell
      end
    end
    hidden_array
  end

  def self.print_grid(array)
    array.each do |row|
      puts row.join(' ')
    end
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end
end
