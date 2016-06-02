class Watcher < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :friends
  validates :vk_id, :name, :photo, :user, presence: true
  validates :vk_id, numericality: true
end
