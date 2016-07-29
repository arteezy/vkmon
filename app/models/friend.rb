class Friend < ApplicationRecord
  has_and_belongs_to_many :watchers
  validates :first_name, :last_name, :photo, :domain, presence: true
  validates :sex, :online, inclusion: { in: [true, false] }

  def parse_birthdate(str)
    if str.size > 5
      Date.parse(str)
    else
      # for cases when year of birth is hidden
      # 2020 is a leap year, handles 29 february and is inside UNIX time bounds
      # it is impossible to register in VK with 2020 birthyear until 2036
      Date.parse("#{str}.2020")
    end
  end

  def map_attributes_from_api(vk_friend)
    self.first_name  = vk_friend[:first_name]
    self.last_name   = vk_friend[:last_name]
    self.sex         = vk_friend[:sex] == 2
    self.nickname    = vk_friend[:nickname]
    self.domain      = vk_friend[:domain]
    self.bdate       = parse_birthdate(vk_friend[:bdate]) if vk_friend[:bdate]
    self.city        = vk_friend[:city][:title] if vk_friend.key?(:city)
    self.country     = vk_friend[:country][:title] if vk_friend.key?(:country)
    self.thumbnail   = vk_friend[:photo_50]
    self.photo       = vk_friend[:photo_200_orig]
    self.has_mobile  = vk_friend[:has_mobile]
    self.online      = vk_friend[:online] == 1
    self.deactivated = vk_friend[:deactivated]
    self.status      = vk_friend[:status]
    self.last_seen   = Time.at(vk_friend[:last_seen][:time]).utc if vk_friend.key?(:last_seen)
    self.platform    = vk_friend[:last_seen][:platform] if vk_friend.key?(:last_seen)
    self.university  = vk_friend[:university_name]
    self.graduation  = vk_friend[:graduation]
  end
end
