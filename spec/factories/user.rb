# frozen_string_literal: true

FactoryBot.define do
  factory :user do

    trait :completed do
      name              { FFaker::Lorem.word }
      email             { FFaker::Internet.email }
      password          { 'secret123' }
      birth_date        { '28/04/2000' }
      phone             { FFaker::PhoneNumber.phone_number }
      cpf               { FFaker::IdentificationBR.cpf }
      terms_acceptation { true }
    end

    trait :establishment do
      name              { FFaker::Lorem.word }
      email             { FFaker::Internet.email }
      password          { 'secret123' }
      birth_date        { '28/04/2000' }
      phone             { FFaker::PhoneNumber.phone_number }
      cpf               { FFaker::IdentificationBR.cpf }
      terms_acceptation { true }
    end

    trait :uncompleted do
      name              { FFaker::Lorem.word }
      email             { FFaker::Internet.email }
      password          { 'secret123' }
      terms_acceptation { true }
    end

    factory :establishment_user, traits: [:establishment]
    factory :completed_user, traits: [:completed]
    factory :uncompleted_user, traits: [:uncompleted]
  end
end
