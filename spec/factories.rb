require 'faker'

FactoryBot.define do
  factory :like do
    association :user, factory: :user
    association :post, factory: :post
  end

  factory :user do
    name { Faker::Name.name }
    posts_counter { 0 }
    photo { Faker::Avatar.image }
  end

  factory :post do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    likes_counter { 0 }
    comments_counter { 0 }
    body { Faker::Lorem.paragraph }
    association :user
  end

  factory :comment do
    text { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    post
    association :user
  end
end
