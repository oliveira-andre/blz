# frozen_string_literal: true

FactoryBot.define do
  factory :professional_service do
    professional
    service

    trait :in_home do
      association :service, :home
    end

    trait :in_establishment do
      association :service, :establishment
    end

    factory :professional_service_in_home, traits: [:in_home]
    factory :professional_service_in_establishment, traits: [:in_establishment]
  end
end
