FactoryBot.define do
  factory :scheduling do
    association :user, :completed
    after(:build) do |scheduling|
      schedule = create(:schedule)
      scheduling.professional_service = schedule.professional_service
      scheduling.date = schedule.date
      if schedule.professional_service.service.home?
        scheduling.in_home = 1
      else
        scheduling.in_home = 0
      end
    end

    trait :busy do
      status           { :busy }
      service_duration { rand(30..480) }
    end

    factory :busy_scheduling, traits: [:busy]
  end
end
