FactoryBot.define do
  factory :book do
    title { 'The Bitcoin Standard' }
    association :author
  end
end
