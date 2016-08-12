require 'rails_helper'

describe FriendsService, type: :service do
  it 'fetches and saves friends of watcher' do
    VCR.use_cassette('id2') do
      watcher = create(:watcher, vk_id: 2)
      fs = FriendsService.new(watcher)
      fs.fetch
      expect(watcher.friends).not_to eq []
    end
  end

  it 'updates friends of watcher without creating new ones' do
    VCR.use_cassette('id2', allow_playback_repeats: true) do
      watcher = create(:watcher, vk_id: 2)
      fs = FriendsService.new(watcher)
      fs.fetch
      expect {
        fs.fetch
      }.not_to change(Friend, :count)
    end
  end
end
