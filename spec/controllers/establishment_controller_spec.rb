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
          establishment: FactoryBot
            .attributes_for(:establishment).merge(
              user_attributes: FactoryBot.attributes_for(:without_term_user),
              address_attributes: FactoryBot.attributes_for(:address)
            )
        }
        expect(response).to render_template(:new)
        expect(assigns(:messages_errors)).to include(
          'Termos de uso não pode ficar em branco'
        )
      end
    end

    context 'without user fields' do
      it 'show error and not create the establishment' do
        post :create, params: {
          establishment: FactoryBot
            .attributes_for(:establishment).merge(
              user_attributes: FactoryBot.attributes_for(:empty_user),
              address_attributes: FactoryBot.attributes_for(:address)
            )
        }
        expect(response).to render_template(:new)
        expect(assigns(:messages_errors)).to include(
          'Email não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Senha não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Nome não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Data de nascimento não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Telefone não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'CPF não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'CPF não é válido'
        )
      end
    end

    context 'without establishment fields' do
      it 'show error and not create the establishment' do
        post :create, params: {
          establishment: FactoryBot
            .attributes_for(:empty_establishment).merge(
              user_attributes: FactoryBot.attributes_for(:completed_user),
              address_attributes: FactoryBot.attributes_for(:address)
            )
        }
        expect(response).to render_template(:new)
        expect(assigns(:messages_errors)).to include(
          'Nome não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Horário de funcionamento não pode ficar em branco'
        )
      end
    end

    context 'without address fields' do
      it 'show error and not create the establishment' do
        post :create, params: {
          establishment: FactoryBot
            .attributes_for(:establishment).merge(
              user_attributes: FactoryBot.attributes_for(:completed_user),
              address_attributes: FactoryBot.attributes_for(:empty_address)
            )
        }
        expect(response).to render_template(:new)
        expect(assigns(:messages_errors)).to include(
          'Rua/Logradouro não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Número não pode ficar em branco'
        )
        expect(assigns(:messages_errors)).to include(
          'Bairro não pode ficar em branco'
        )
      end
    end

    context 'user fields that already exist' do
      it 'stay in the same page and show uniqueness errors' do
        user = FactoryBot.create(:completed_user)
        post :create, params: {
          establishment: FactoryBot
            .attributes_for(:establishment).merge(
              user_attributes: user.attributes,
              address_attributes: FactoryBot.attributes_for(:address)
            )
        }
        expect(response).to render_template(:new)
        expect(assigns(:messages_errors)).to include('Email já está em uso')
        expect(assigns(:messages_errors)).to include('CPF já está em uso')
      end
    end

    context 'completing all fields correctly' do
      it 'create with success' do
        user = FactoryBot.attributes_for(:completed_user)
        post :create, params: {
          establishment: FactoryBot
            .attributes_for(:establishment).merge(
              user_attributes: user,
              address_attributes: FactoryBot.attributes_for(:address)
            )
        }
        expect(response).to redirect_to(
          feedbacks_pt_br_path(email: user[:email])
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
