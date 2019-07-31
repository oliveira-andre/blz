# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstablishmentsController, type: :controller do
  describe 'new establishment' do
    pending
  end

  describe 'create establishment' do
    context 'without accept the term' do
      it 'show error and not create the establishment' do
        post :create, params: {
          establishment: {
            name: FFaker::BaconIpsum.word,
            self_employed: 0,
            timetable: 'Das 08:00 às 18:00',
            address_attributes: {
              zipcode: FFaker::AddressBR.zip_code,
              street: FFaker::AddressBR.street_name,
              neighborhood: FFaker::AddressBR.neighborhood,
              number: FFaker::AddressBR.building_number
            },
            user_attributes: {
              name: FFaker::BaconIpsum.word,
              cpf: FFaker::IdentificationBR.cpf,
              email: FFaker::Internet.email,
              birth_date: FFaker::Time.between(25.years.ago, 18.years.ago),
              phone: FFaker::PhoneNumberCH.mobile_phone_number,
              password: 'secret123',
              password_confirmation: 'secret123',
              terms_acceptation: 0
            }
          }
        }
        subject.stub(:create)
        expect(assigns(:messages_errors)).to eq(
          ['Termos de uso não pode ficar em branco']
        )
      end
    end

    context 'without address fields' do
      it 'show error and not create the establishment' do
        post :create, params: {
          establishment: {
            name: FFaker::BaconIpsum.word,
            self_employed: 0,
            timetable: 'Das 08:00 às 18:00',
            address_attributes: {
              zipcode: '',
              street: '',
              neighborhood: '',
              number: ''
            },
            user_attributes: {
              name: FFaker::BaconIpsum.word,
              cpf: FFaker::IdentificationBR.cpf,
              email: FFaker::Internet.email,
              birth_date: FFaker::Time.between(25.years.ago, 18.years.ago),
              phone: FFaker::PhoneNumberCH.mobile_phone_number,
              password: 'secret123',
              password_confirmation: 'secret123',
              terms_acceptation: 1
            }
          }
        }
        subject.stub(:create)
        expect(assigns(:messages_errors)).to eq(
          ['Rua/Logradouro não pode ficar em branco',
           'Número não pode ficar em branco',
           'Bairro não pode ficar em branco']
        )
      end
    end

    context 'completing all fields correctly' do
      it 'create with success' do
        random_email = FFaker::Internet.email
        post :create, params: {
          establishment: {
            name: FFaker::BaconIpsum.word,
            self_employed: 0,
            timetable: 'Das 08:00 às 18:00',
            address_attributes: {
              zipcode: FFaker::AddressBR.zip_code,
              street: FFaker::AddressBR.street_name,
              neighborhood: FFaker::AddressBR.neighborhood,
              number: FFaker::AddressBR.building_number
            },
            user_attributes: {
              name: FFaker::BaconIpsum.word,
              cpf: FFaker::IdentificationBR.cpf,
              email: random_email,
              birth_date: FFaker::Time.between(25.years.ago, 18.years.ago),
              phone: FFaker::PhoneNumberCH.mobile_phone_number,
              password: 'secret123',
              password_confirmation: 'secret123',
              terms_acceptation: 1
            }
          }
        }
        expect(response).to redirect_to(
          feedbacks_pt_br_path(email: random_email)
        )
      end
    end
  end

  describe 'show scheduling' do
    context 'pending' do
      pending
    end
  end
end
