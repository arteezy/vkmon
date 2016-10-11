require 'rails_helper'

describe WatchersFriendsService, type: :service do
  it 'fetches and saves friends of watcher' do
    VCR.use_cassette('id2') do
      watcher = create(:watcher, vk_id: 2)
      fs = WatchersFriendsService.new(watcher)
      fs.fetch_friends
      expect(watcher.friends).not_to eq []
    end
  end

  it 'updates friends of watcher without creating new ones' do
    VCR.use_cassette('id2', allow_playback_repeats: true) do
      watcher = create(:watcher, vk_id: 2)
      fs = WatchersFriendsService.new(watcher)
      fs.fetch_friends
      expect {
        fs.fetch_friends
      }.not_to change(Friend, :count)
    end
  end
end
