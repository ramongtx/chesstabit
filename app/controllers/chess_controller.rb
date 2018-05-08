class ChessController < ApplicationController
  def index
    @board = ChessBoard.new
  end

  def show
    params[:id] = 'startup' unless %w[01 02 03 startup].include?(params[:id])
    @name = "chess-#{params[:id]}.txt"
    @board = ChessBoard.new(File.open("app/files/#{@name}"))
    render :index
  end
end
