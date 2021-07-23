# frozen_string_literal: true

FactoryBot.define do
  factory :scheduling do
    association :user, :completed
    after(:build) do |scheduling|
      schedule = create(:schedule)
      scheduling.professional_service = schedule.professional_service
      scheduling.date = schedule.date
      scheduling.in_home = if schedule.professional_service.service.home?
                             1
                           else
                             0
                           end
    end

    trait :busy do
      status           { :busy }
      service_duration { rand(30..480) }
    end

    factory :busy_scheduling, traits: [:busy]
  end
end
