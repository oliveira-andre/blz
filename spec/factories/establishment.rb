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

    factory :approved_establishment, traits: [:approved]
    factory :disapproved_establishment, traits: [:disapproved]
  end
end