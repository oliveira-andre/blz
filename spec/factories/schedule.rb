FactoryBot.define do
  factory :schedule do
    date { Time.now + 1.hour }
    professional_service
  end
end
