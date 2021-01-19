FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "MyString" }
    api_key { Faker::Internet.uuid }
  end
end
