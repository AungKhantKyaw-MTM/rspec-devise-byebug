FactoryBot.define do
  factory :user do
    email { 'akk@gmail.com' }
    password { 'asd123' }
    password_confirmation { 'asd123' }
  end
end
