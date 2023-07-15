require 'faker'

FactoryBot.define do
  factory :like do
    association :user, factory: :user
    association :post, factory: :post
  end

  factory :post do
    title { Faker::Lorem.sentence }
    text { Faker::Lorem.paragraph }
    likes_counter { 0 }
    comments_counter { 0 }
    association :author, factory: :user
  end

  factory :user do
    name { Faker::Name.name }
    posts_counter { 0 }
    photo { Faker::Avatar.image }
  end
  factory :comment do
    text { Faker::Lorem.sentence }
    post
    author { association :user }
  end
end
