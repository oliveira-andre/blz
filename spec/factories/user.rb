# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name              { FFaker::Lorem.word }
    email             { FFaker::Internet.email }
    password          { 'secret123' }
    terms_acceptation { true }

    trait :completed do
      birth_date        { '28/04/2000' }
      phone             { FFaker::PhoneNumber.phone_number }
      cpf               { FFaker::IdentificationBR.cpf }
    end

    factory :completed_user, traits: [:completed]
  end
end
