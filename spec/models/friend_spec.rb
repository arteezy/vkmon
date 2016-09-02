require 'rails_helper'

describe Friend, type: :model do
  it 'has a valid factory' do
    expect(build(:friend)).to be_valid
  end

  context 'validations' do
    it 'is invalid without first_name' do
      friend = build(:friend, first_name: nil)
      friend.valid?
      expect(friend.errors[:first_name]).to include('can\'t be blank')
    end

    it 'is valid with empty string last_name' do
      expect(build(:friend, last_name: '')).to be_valid
    end

    it 'is invalid with nil last_name' do
      friend = build(:friend, last_name: nil)
      friend.valid?
      expect(friend.errors[:last_name]).to include('can\'t be nil')
    end

    it 'is invalid without photo' do
      friend = build(:friend, photo: nil)
      friend.valid?
      expect(friend.errors[:photo]).to include('can\'t be blank')
    end

    it 'is invalid without thumbnail' do
      friend = build(:friend, thumbnail: nil)
      friend.valid?
      expect(friend.errors[:thumbnail]).to include('can\'t be blank')
    end

    it 'is invalid without domain' do
      friend = build(:friend, domain: nil)
      friend.valid?
      expect(friend.errors[:domain]).to include('can\'t be blank')
    end
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
