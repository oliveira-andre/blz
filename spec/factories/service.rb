FactoryBot.define do
  factory :service do
    title               { FFaker::Lorem.unique.word }
    status              { :approved }
    local_type          { Service.local_types.keys.sample }
    description         { FFaker::Lorem.sentence }
    amount              { 111 }
    duration            { 30 }
    category_id         { Category.ids.sample }
    establishment

    trait :home do
      local_type { :home }
    end

    trait :not_approved do
      status { %i[recused awaiting_avaliation archived].sample }
    end

    factory :service_in_home, traits: [:home]
  end
end
