FactoryBot.define do
  factory :office_hour do
    hour_begin         { rand(1..7) }
    hour_end           { rand(0101..2359) }
    week_day           { rand(1..7) }
    professional
  end
end