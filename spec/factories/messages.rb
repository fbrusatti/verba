# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user
    subject Faker::Lorem.sentence
    body    Faker::Lorem.paragraph
    email   Faker::Internet.email
  end
end
