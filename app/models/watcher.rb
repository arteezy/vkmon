class Watcher < ApplicationRecord
  belongs_to :user
  validates :vk_id, :name, :photo, :user, presence: true
  validates :vk_id, numericality: true
end
