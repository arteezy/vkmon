require 'rails_helper'

describe Watcher, type: :model do
  it 'has a valid factory' do
    expect(build(:watcher)).to be_valid
  end

  context 'validations' do
    it 'is invalid without VK id' do
      watcher = build(:watcher, vk_id: nil)
      watcher.valid?
      expect(watcher.errors[:vk_id]).to include('can\'t be blank')
    end

    it 'is invalid with non-numeric VK id' do
      watcher = build(:watcher, vk_id: 'lorem')
      watcher.valid?
      expect(watcher.errors[:vk_id]).to include('is not a number')
    end

    it 'is invalid without a name' do
      watcher = build(:watcher, name: nil)
      watcher.valid?
      expect(watcher.errors[:name]).to include('can\'t be blank')
    end

    it 'is invalid without a domain' do
      watcher = build(:watcher, domain: nil)
      watcher.valid?
      expect(watcher.errors[:domain]).to include('can\'t be blank')
    end

    it 'is invalid without a photo' do
      watcher = build(:watcher, photo: nil)
      watcher.valid?
      expect(watcher.errors[:photo]).to include('can\'t be blank')
    end

    it 'is invalid without a user' do
      watcher = build(:watcher, user: nil)
      watcher.valid?
      expect(watcher.errors[:user]).to include('can\'t be blank')
    end
  end

  context 'counter cache for associated friends' do
    let(:watcher) { create(:watcher) }

    it 'correctly updates counter' do
      2.times { create(:friend, watchers: [watcher]) }
      expect {
        watcher.update_friends_count
      }.to change(watcher, :friends_count).by(2)
    end

    it 'correctly decrements' do
      friend = create(:friend, watchers: [watcher])
      watcher.update_friends_count
      expect {
        friend.destroy
      }.to change(watcher, :friends_count).by(-1)
    end
  end
end
