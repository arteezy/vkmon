class FetchFriendsJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    vk = VK.new(watcher.vk_id)
    friends = vk.friends['response']['items']
    Friend.transaction do
      friends.each do |friend|
        temp = Friend.find_or_initialize_by(id: friend['id'])
        temp.map_attributes_from_api(friend)
        temp.watchers.push(watcher)
        temp.save!
      end
    end
  end
end
