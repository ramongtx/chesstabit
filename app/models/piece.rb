class Piece
  include ActiveModel::Validations

  ROLES = %i[king queen bishop knight rook pawn].freeze
  COLORS = %i[white black].freeze

  CODES = {
    'oɹ' => %i[white rook],
    'uʞ' => %i[white knight],
    'ıq' => %i[white bishop],
    'nb' => %i[white queen],
    'ıʞ' => %i[white king],
    'ɐd' => %i[white pawn],
    'ro' => %i[black rook],
    'kn' => %i[black knight],
    'bi' => %i[black bishop],
    'qu' => %i[black queen],
    'ki' => %i[black king],
    'pa' => %i[black pawn]
  }.freeze

  INVERTED_CODES = CODES.invert.freeze

  attr_accessor :color, :role

  validates :color, presence: true, inclusion: COLORS
  validates :role, presence: true, inclusion: ROLES

  def to_code
    INVERTED_CODES.fetch([color, role], '??')
  end

  def initialize(color, role)
    @color = color
    @role = role
  end

  def self.from_code(code)
    Piece.new(*CODES.fetch(code, [nil, nil]))
  end
end
