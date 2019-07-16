FactoryBot.define do
  factory :professional do
    name             { FFaker::Lorem.word }
    description      { FFaker::Lorem.sentence }
  end
end