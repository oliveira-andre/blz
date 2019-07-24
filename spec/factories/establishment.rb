FactoryBot.define do
  factory :establishment do

    trait :approved do
      name          { FFaker::Lorem.word }
      timetable     { 'Das 00:00 às 12:00' }
      status        { :approved }
      association   :user, :establishment
    end

    trait :disapproved do
      name          { FFaker::Lorem.word }
      timetable     { 'Das 00:00 às 12:00' }
      status        { :disapproved }
      association   :user, :establishment
    end

    factory :approved_establishment, traits: [:approved]
    factory :disapproved_establishment, traits: [:disapproved]
  end
end