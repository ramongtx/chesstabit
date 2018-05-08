class ChessController < ApplicationController
  def index
    @board = ChessBoard.new
  end
end
