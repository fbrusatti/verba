# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authorization do
    provider    "MyString"
    uid         "MyString"
    token       "MyString"
    secret      "MyString"
    nickname    "MyString"
    name        "MyString"
    email       "MyString"
    image       "MyString"
    description "MyText"
    urls        "MyText"
    location    "MyString"
    user nil
  end
end
