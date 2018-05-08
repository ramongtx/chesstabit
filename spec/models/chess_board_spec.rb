require 'rails_helper'

RSpec.describe ChessBoard, type: :model do
  subject { ChessBoard.new }

  it { expect(subject).to be_valid }

  describe 'validations' do
    subject { ChessBoard.new(File.open('spec/fixtures/chess-too-many-pawns.txt').read) }

    it { expect(subject).to be_invalid }
  end

  describe '#to_text' do
    it { expect(subject.to_text).to eq(File.open('app/files/chess-startup.txt').read) }
  end
end
