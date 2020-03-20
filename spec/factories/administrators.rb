FactoryBot.define do
  factory :administrator do
    sequence(:login_id) {|n| "#{Faker::Internet.username}#{n}" }
    name { Faker::Name.name }
    email { "#{login_id}@example.com" }
    password { 'Password001' }
  end
end
