FactoryBot.define do
  factory :establishment do
    name          { FFaker::Lorem.word }
    timetable     { 'Das 00:00 às 12:00' }
    status        { :approved }
    association   :user, :establishment
  end
end