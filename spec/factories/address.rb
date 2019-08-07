FactoryBot.define do
  factory :address do
    zipcode      { FFaker::AddressBR.zip_code }
    street       { FFaker::AddressBR.street_name }
    neighborhood { FFaker::AddressBR.neighborhood }
    number       { FFaker::AddressBR.building_number }
    addressable  { association(:establishment) }

    trait :empty do
      zipcode      { '' }
      street       { '' }
      neighborhood { '' }
      number       { '' }
    end

    factory :empty_address, traits: [:empty]
  end
end
