class ChessBoard
  include ActiveModel::Validations

  attr_accessor :cells

  def initialize(file = nil)
    @cells = {}
    reset_cells unless file
  end

  def reset_cells
    color = :white
    %i[rook knight bishop queen king bishop knight rook].each_with_index do |role, index|
      cells[[0, index]] = Piece.new(color, role)
    end
    8.times { |i| cells[[1, i]] = Piece.new(color, :pawn) }

    color = :black
    8.times { |i| cells[[6, i]] = Piece.new(color, :pawn) }
    %i[rook knight bishop queen king bishop knight rook].each_with_index do |role, index|
      cells[[7, index]] = Piece.new(color, role)
    end
  end

  def to_text
    Array.new(8) do |x|
      "#{8 - x} |" +
        Array.new(8) do |y|
          cell = cells[[x, y]]
          cell.present? ? cell.to_code : '  '
        end.join('|') + '|'
    end.join("\n") + "\n   a  b  c  d  e  f  g  h"
  end
end
