FactoryBot.define do
  factory :office_hour do
    hour_begin         { 0 }
    hour_end           { 1111 }
    week_day           { :segunda }
    professional
  end
end