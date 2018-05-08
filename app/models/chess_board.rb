class ChessBoard
  include ActiveModel::Validations

  PIECE_NUMBERS = {
    %i[white rook] => 2,
    %i[white knight] => 2,
    %i[white bishop] => 2,
    %i[white queen] => 1,
    %i[white king] => 1,
    %i[white pawn] => 8,
    %i[black rook] => 2,
    %i[black knight] => 2,
    %i[black bishop] => 2,
    %i[black queen] => 1,
    %i[black king] => 1,
    %i[black pawn] => 8
  }.freeze

  attr_accessor :cells

  validate :pieces_validation
  validate :piece_numbers_validation

  def initialize(file = nil)
    @cells = {}
    file.present? ? import_cells(file) : reset_cells
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
    end.join("\r\n") + "\r\n   a  b  c  d  e  f  g  h\r\n"
  end

  def import_cells(file)
    line_number = 0
    file.each_line do |line|
      break if line_number > 7
      line.split('|')[1..-2].each_with_index do |code, index|
        cells[[line_number, index]] = Piece.from_code(code) if code.strip.present?
      end
      line_number += 1
    end
  end

  private

  def pieces_validation
    errors.add(:cells, :invalid) unless cells.values.all?(&:valid?)
  end

  def piece_numbers_validation
    grouped_pieces = cells.values.group_by { |piece| [piece.color, piece.role] }
    grouped_pieces.each do |key, value|
      errors.add(:cells, :invalid) if value.count > PIECE_NUMBERS.fetch(key, 0)
    end
  end
end
