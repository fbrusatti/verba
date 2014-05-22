# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@mail.com"
  end

  factory :user do
    email
    password  '12345678'
    admin     false
  end

  factory :admin, class: User do
    email
    password '12345678'
    admin    true
  end
end
