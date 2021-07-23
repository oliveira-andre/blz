# frozen_string_literal: true

FactoryBot.define do
  factory :professional do
    name             { FFaker::Lorem.word }
    description      { FFaker::Lorem.sentence }
    establishment

    after(:create) do |professional|
      create_list(:office_hour, 1, hour_begin: 0, hour_end: 1111,
                                   week_day: :segunda, professional: professional)
    end
  end
end
