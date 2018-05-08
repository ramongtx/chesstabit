require 'rails_helper'

RSpec.describe Piece, type: :model do
  subject { Piece.new(:black, :king) }

  it { expect(subject.color).to eq(:black) }
  it { expect(subject.role).to eq(:king) }
  it { expect(subject.to_code).to eq('ki') }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:color) }
    it { is_expected.to validate_presence_of(:role) }
  end

  describe '.from_code' do
    subject { Piece.from_code('ɐd') }

    it { expect(subject.color).to eq(:white) }
    it { expect(subject.role).to eq(:pawn) }
    it { expect(subject.to_code).to eq('ɐd') }
  end
end
