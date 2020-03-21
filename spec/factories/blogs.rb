FactoryBot.define do
  factory :blog do
    user
    sequence(:title) { |n| "title#{n}" }
    sequence(:body) { |n| "body#{n}\nbody#{n}" }
    status { :published }
  end
end
