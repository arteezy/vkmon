class FriendsService
  def initialize(watcher)
    @watcher = watcher
  end

  def fetch
    vk = VK.new(@watcher.vk_id)
    friends = vk.friends[:response][:items]
    old_friends = @watcher.friends.pluck(:id)
    new_friends = friends.map { |i| i[:id] }

    save_friends(friends)

    return if old_friends.empty?
    @watcher.added_friends_ids   |= new_friends - old_friends
    @watcher.deleted_friends_ids |= old_friends - new_friends
    @watcher.save!
  end

  private

  def save_friends(friends)
    Friend.transaction do
      friends.each do |friend|
        new_friend = Friend.find_or_initialize_by(id: friend[:id])
        new_friend.map_attributes_from_api(friend)
        new_friend.watchers |= [@watcher]
        new_friend.save!
      end
    end
  end
end
