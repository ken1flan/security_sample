FactoryBot.define do
  factory :measurement_tag do
    user
    sequence(:body) { |n| "<script>console.log('mesurement_tag#{n}');</script>" }
  end
end
