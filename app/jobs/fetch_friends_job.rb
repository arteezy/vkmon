class FetchFriendsJob < ApplicationJob
  queue_as :default

  def perform(watcher)
    vk = VK.new(watcher.vk_id)
    friends = vk.friends['response']['items']
    old_friends = watcher.friends.pluck(:id)
    new_friends = friends.map { |i| i['id'] }

    Friend.transaction do
      friends.each do |friend|
        temp = Friend.find_or_initialize_by(id: friend['id'])
        temp.map_attributes_from_api(friend)
        temp.watchers |= [watcher]
        temp.save!
      end
    end

    return if old_friends.empty?
    watcher.added_friends |= new_friends - old_friends
    watcher.deleted_friends |= old_friends - new_friends
    watcher.save!
  end
end
