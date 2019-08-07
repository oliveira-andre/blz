FactoryBot.define do
  factory :establishment do
    name          { FFaker::Lorem.word }
    timetable     { 'Das 00:00 às 12:00' }
    association   :user, :completed

    trait :approved do
      status        { :approved }
    end

    trait :disapproved do
      status        { :disapproved }
    end

    trait :empty do
      name          { '' }
      timetable     { '' }
    end
  
    trait :with_services do
      after(:create) do |establishment, _evaluator|
        create_list(:service, 10, establishment: establishment)
      end
    end

    factory :approved_establishment, traits: [:approved]
    factory :disapproved_establishment, traits: [:disapproved]
    factory :empty_establishment, traits: [:empty]
    factory :establishment_with_services, traits: %i[approved with_services]
  end
end
