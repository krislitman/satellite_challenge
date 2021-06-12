FactoryBot.define do
  factory :satellite do
    sequence(:altitude) { |n| 180 + n }
    last_updated { Time.now }
  end
end