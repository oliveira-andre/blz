# frozen_string_literal: true

require 'ffaker'

## Categories
barber_category = Category.find_or_create_by!(
  name: 'Barbearia',
  description: 'Cuidados para os homens',
  order: 1
)

Category.find_or_create_by!(
  name: 'Cabelo',
  description: 'Cortes, penteados. pintura e alisamentos. Tudo para o cabelo',
  order: 2
)

Category.find_or_create_by!(
  name: 'Corpo',
  description: 'Cuidados com o corpo, como depilação, massagens, etc.',
  order: 3
)

Category.find_or_create_by!(
  name: 'Maquiagem',
  description: 'Maquiagem para casamento, festas, entre outros e design de sobracelha',
  order: 4
)

Category.find_or_create_by!(
  name: 'Unhas',
  description: 'Tudo para unhas: manicure e pedicute',
  order: 5
)

Category.find_or_create_by!(
  name: 'Outros',
  description: 'Demais categorias',
  order: 6
)

## Fake Services

User.new(
  name: FFaker::NameBR.name,
  cpf: FFaker::IdentificationBR.cpf,
  phone: FFaker::PhoneNumberBR.phone_number,
  terms_acceptation: true,
  birth_date: Time.now - 20.years,
  email: 'admin@example.com',
  password: 'safe12311',
  password_confirmation: 'safe12311',
  profile: :admin
).save

barber_user = User.new(
  name: FFaker::NameBR.name,
  cpf: FFaker::IdentificationBR.cpf,
  phone: FFaker::PhoneNumberBR.phone_number,
  terms_acceptation: true,
  email: 'barber@example.com',
  password: 'safe12311',
  password_confirmation: 'safe12311',
  birth_date: Time.now - 20.years
)
barber_user.save!

barber_establishment = Establishment.find_or_create_by!(
  name: "Cabelereiro #{FFaker::NameBR.first_name}",
  status: :approved,
  timetable: "Segunda a Sexta dás 08:30 até 19:00",
  self_employed: true,
  about: FFaker::Book.description,
  user: barber_user
)

Service.find_or_create_by!(
  title: 'Corte profissional de cabelo e barba',
  description: FFaker::Book.description,
  status: :approved,
  local_type: :home,
  amount: 100,
  category: barber_category,
  duration: 30,
  establishment: barber_establishment,
  start_from: true
)
