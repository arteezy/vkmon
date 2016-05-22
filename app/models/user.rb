class User < ApplicationRecord
  include Clearance::User
  has_many :watchers, dependent: :destroy
end
