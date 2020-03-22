FactoryBot.define do
  factory :user do
    sequence(:login_id) {|n| "#{Faker::Internet.username}#{n}" }
    name { Faker::Name.name }
    email { "#{login_id}@example.com" }
    password { 'Password001' }
    self_introduction { Faker::Lorem.paragraph_by_chars }
    homepage { Faker::Internet.url }
  end
end
