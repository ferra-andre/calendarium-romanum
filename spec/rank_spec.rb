require_relative 'spec_helper'

describe CR::Rank do
  describe 'comparison' do
    it 'memorial x ferial' do
      expect(CR::Ranks::MEMORIAL_GENERAL).to be > CR::Ranks::FERIAL
    end
  end

  describe '[]' do
    it 'has all existing instances indexed by rank number' do
      expect(CR::Ranks[1.1]).to eq CR::Ranks::TRIDUUM
    end
  end

  describe '#<' do
    it { expect(CR::Ranks[1.2]).to be < CR::Ranks[1.1] }
    it { expect(CR::Ranks[1.1]).not_to be < CR::Ranks[1.2] }
  end

  describe '#>' do
    it { expect(CR::Ranks[1.1]).to be > CR::Ranks[1.2] }
    it { expect(CR::Ranks[1.2]).not_to be > CR::Ranks[1.1] }
  end

  describe '#==' do
    it { expect(CR::Ranks[1.2]).to be == CR::Ranks[1.2] }
    it { expect(CR::Ranks[1.2]).not_to be == CR::Ranks[1.1] }
  end

  describe '#desc' do
    it { expect(CR::Ranks[1.1].desc).to eq 'Easter triduum' }
  end

  describe '#short_desc' do
    it 'is not always set' do
      expect(CR::Ranks[1.1].short_desc).to be_nil
    end

    it { expect(CR::Ranks[2.8].short_desc).to eq 'feast' }
  end
end
