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
        subject.stub(:create)
        expect(assigns(:messages_errors)).to include(
          'Termos de uso não pode ficar em branco'
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
        subject.stub(:create)
        expect(assigns(:messages_errors)).to include(
          'Rua/Logradouro não pode ficar em branco'
        )
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
