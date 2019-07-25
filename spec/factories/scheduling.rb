FactoryBot.define do
  factory :scheduling do
    in_home { 0 }
    association :user, :completed
    after(:build) do |scheduling|
      schedule = create(:schedule)
      scheduling.professional_service = schedule.professional_service
      scheduling.date = schedule.date
    end
  end
end