require 'faker'

FactoryGirl.define do
  factory :story do |f|
    f.url { Faker::Internet.url }
    f.pic_url { Faker::Avatar.image }
    f.modified {Faker::Date.backward(14)}
    f.full_text {Faker::Lorem.paragraph(2, true, 4)}
    f.area "music"||"education"
    f.source { Faker::Name.title }
    f.title { Faker::Hacker.say_something_smart }
  end
end