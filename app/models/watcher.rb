class Watcher < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :friends
  validates :vk_id, :name, :photo, :user, presence: true
  validates :vk_id, numericality: true

  def self.parse_vk_id(vk_url)
    return if vk_url.empty?
    regex = %r{(http(s)?:\/\/)?(vkontakte\.ru|vk\.com)?\/?[a-zA-Z0-9._]+}
    match = regex.match(vk_url)
    match[0].split('/').last
  end
end
