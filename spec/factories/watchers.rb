FactoryGirl.define do
  factory :watcher do
    vk_id { Faker::Number.number(5) }
    name { Faker::Name.name }
    photo { Faker::Avatar.image('photo', '300x300', 'jpg') }

    association :user, factory: :user
  end
end
