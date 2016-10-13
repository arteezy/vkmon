class Watcher < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :friends, -> { order(first_name: :asc) }

  validates :vk_id, :name, :photo, :domain, :user, presence: true
  validates :vk_id, numericality: true

  default_scope { order(created_at: :desc) }

  def map_api_attributes(vk_user)
    self.vk_id     = vk_user[:id]
    self.name      = "#{vk_user[:first_name]} #{vk_user[:last_name]}"
    self.domain    = vk_user[:domain]
    self.photo     = vk_user[:photo_50]
    self.last_seen = Time.at(vk_user[:last_seen][:time]).utc if vk_user.key?(:last_seen)
  end

  def update_friends_count
    self.friends_count = friend_ids.count
  end

  def self.parse_vk_id(vk_url)
    return if vk_url.empty?
    regex = %r{(http(s)?:\/\/)?(vkontakte\.ru|vk\.com)?\/?[a-zA-Z0-9._]+}
    match = regex.match(vk_url)
    match[0].split('/').last
  end
end
