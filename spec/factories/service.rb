FactoryBot.define do
  factory :service do
    title               { FFaker::Lorem.word }
    local_type          { :establishment }
    description         { FFaker::Lorem.sentence }
    amount              { 111 }
    duration            { 30 }
    category
    establishment
  end
end