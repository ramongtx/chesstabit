require 'rails_helper'

RSpec.describe ChessBoard, type: :model do
  subject { ChessBoard.new }

  it { expect(subject).to be_valid }
  it { expect(subject.cells[[7, 4]].color).to eq(:black) }
  it { expect(subject.cells[[7, 4]].role).to eq(:king) }

  describe 'validations' do
    context 'too many pawns' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-too-many-pawns.txt').read) }

      it { expect(subject).to be_invalid }
    end

    context 'too many kings' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-too-many-kings.txt').read) }

      it { expect(subject).to be_invalid }
    end

    context 'wrong pieces' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-wrong-pieces.txt').read) }

      it { expect(subject).to be_invalid }
    end

    context 'empty board' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-empty.txt').read) }

      it { expect(subject).to be_valid }
    end
  end

  describe '#to_text' do
    it { expect(subject.to_text).to eq(File.open('app/files/chess-startup.txt').read) }

    context 'wrong pieces' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-wrong-pieces.txt').read) }

      it { expect(subject.to_text).to eq(File.open('spec/fixtures/chess-wrong-pieces-out.txt').read) }
    end

    context 'empty board' do
      subject { ChessBoard.new(File.open('spec/fixtures/chess-empty.txt').read) }

      it { expect(subject.to_text).to eq(File.open('spec/fixtures/chess-empty.txt').read) }
    end
  end
end
