FactoryBot.define do
  factory :post do
    title { 'Post' }
    content { 'This is a post.' }
    association :user
  end
end
