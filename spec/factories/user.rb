FactoryBot.define do
  factory :user do
    name              { FFaker::Lorem.word }
    email             { FFaker::Internet.email }
    password          { 'secret123' }
    terms_acceptation { true }
  end
end