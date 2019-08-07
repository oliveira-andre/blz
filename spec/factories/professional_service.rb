FactoryBot.define do
  factory :professional_service do
    professional
    service

    trait :in_home do
      association :service, :home
    end

    factory :professional_service_in_home, traits: [:in_home]
  end
end
