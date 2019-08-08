# doc to datetime ffaker: https://www.rubydoc.info/github/ffaker/ffaker/FFaker/Time#datetime-instance_method

FactoryBot.define do
  factory :schedule do
    date { FFaker::Time.datetime(year_latest: 0, year_range: -1) }
    professional_service

    trait :in_home do
      association :professional_service, :in_home
    end

    trait :in_establishment do
      association :professional_service, :in_establishment
    end

    factory :schedule_in_home, traits: [:in_home]
    factory :schedule_in_establishment, traits: [:in_establishment]
  end
end
