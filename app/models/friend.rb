class Friend < ApplicationRecord
  has_and_belongs_to_many :watchers
  validates :first_name, :last_name, :photo, :sex, :domain, :online, presence: true
end
