# doc to datetime ffaker: https://www.rubydoc.info/github/ffaker/ffaker/FFaker/Time#datetime-instance_method

FactoryBot.define do
  factory :schedule do
    date { FFaker::Time.datetime(year_latest: 0, year_range: -1) }
    professional_service
  end
end
