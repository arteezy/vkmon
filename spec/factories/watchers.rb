FactoryGirl.define do
  factory :watcher do
    vk_id { Faker::Number.number(5) }
    name { Faker::Name.name }
    domain { Faker::Internet.domain_word }
    photo { Faker::Avatar.image('photo', '300x300', 'jpg') }
    last_seen { Faker::Time.backward(3, :morning) }

    association :user, factory: :user
  end
end
