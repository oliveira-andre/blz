# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EstablishmentsController, type: :controller do
  describe 'new establishment' do
    context "when user isn't logged" do
      it 'access page with success' do
        get :new
        expect(response).to have_http_status(:successful)
      end
    end

    context 'when user is logged' do
      it 'show error and redirect to root page' do
        sign_in FactoryBot.create(:user)
        get :new
        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end
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

  describe 'show establishhment' do
    context 'pending' do
      pending
    end
  end

  describe 'edit establishhment' do
    context 'when user is not logged in' do
      it 'show error and redirect to sign_in page' do
        establishment = create(:establishment)
        get :edit, params: { id: establishment.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is logged in' do
      context 'when user is blocked' do
        it 'show error and redirect to root_path' do
          establishment = create(:establishment)
          sign_in create(:blocked_user)
          get :edit, params: { id: establishment.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is common' do
        it 'show error and redirecto to root_path' do
          establishment = create(:establishment)
          sign_in create(:user)
          get :edit, params: { id: establishment.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is a establishment' do
        context 'when try to access id of another establishment' do
          it 'show error and redirect to root_path' do
            establishment = create(:establishment)
            another_establishment = create(:establishment)
            sign_in establishment.user
            get :edit, params: { id: another_establishment.id }
            expect(flash[:error]).to eq('Não autorizado')
            expect(response).to redirect_to(root_path)
          end
        end

        context 'when try to access your self establishment' do
          it 'access with success' do
            establishment = create(:establishment)
            sign_in establishment.user
            get :edit, params: { id: establishment.id }
            expect(response).to have_http_status(:successful)
            expect(response).to render_template(:edit)
          end
        end
      end
    end
  end
end
