FactoryGirl.define do
  factory :friend do
    id { Faker::Number.number(7) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sex { Faker::Boolean.boolean }
    nickname { Faker::Internet.user_name }
    domain { Faker::Internet.domain_word }
    bdate { Faker::Date.between(40.years.ago, 16.years.ago) }
    city { Faker::Address.city }
    country { Faker::Address.country }
    photo { Faker::Avatar.image }
    thumbnail { Faker::Avatar.image }
    has_mobile { Faker::Boolean.boolean }
    online { Faker::Boolean.boolean }
    status { Faker::Lorem.sentence }
    last_seen { Faker::Time.backward(3, :morning) }
    platform { Faker::Number.digit }
    university { Faker::University.name }
    graduation { Faker::Number.between(1970, 2038) }

    factory :banned_friend do
      deactivated 'banned'
    end
  end
end
