FactoryBot.define do
  factory :service do
    title               { FFaker::Lorem.word }
    status              { :approved }
    local_type          { :establishment }
    description         { FFaker::Lorem.sentence }
    amount              { 111 }
    duration            { 30 }
    category            { Category.find(rand(1..6)) }
    establishment

    trait :home do
      local_type        { :home }
    end

    factory :service_in_home, traits: [:home]
  end
end
