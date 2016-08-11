require 'rails_helper'

RSpec.describe Friend, type: :model do
  it 'has a valid factory' do
    expect(build(:friend)).to be_valid
  end

  context 'birthdate' do
    let(:friend) { create(:friend) }

    it 'is correctly parsed' do
      date = friend.send(:parse_birthdate, '23.9.1975')
      expect(date).to eq Date.new(1975, 9, 23)
    end

    it 'is correctly parsed without year' do
      date = friend.send(:parse_birthdate, '3.2')
      expect(date).to eq Date.new(2020, 2, 3)
    end

    it 'is correctly parsed with leap year' do
      date = friend.send(:parse_birthdate, '29.2.2000')
      expect(date).to eq Date.new(2000, 2, 29)
    end
  end
end
