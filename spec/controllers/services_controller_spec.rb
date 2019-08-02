# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::ServicesController, type: :controller do

  describe 'index service' do
    context 'when user is not authenticated' do
      it 'redirect to sign in' do
        get :index, params: { establishment_id: 0 }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated and not a establishment' do
      let(:establishment) { create(:establishment_with_services) }

      it 'show error message and redirect to home page' do
        establishment = create(:establishment)

        sign_in create(:user)

        get :index, params: { establishment_id: establishment.id }

        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is authenticated and a establishment' do
      it 'show only your services and render index template' do
        establishment = create(:establishment_with_services)
        create_list(:service, 10)

        sign_in establishment.user

        get :index, params: { establishment_id: establishment.id }

        current_services_ids = assigns(:services).ids
        expect(current_services_ids).to eq(establishment.services.ids)
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'show service' do
    context 'when service_id sended is approved' do
      it 'render show page with right service' do
        service = create(:service)

        get :show, params: { id: service.id }

        expect(assigns(:service).id).to eq(service.id)
        expect(response).to render_template(:show)
      end
    end

    context 'when service_id sended is not approved' do
      it 'show error message and redirect to home page' do
        service = create(:service, :not_approved)

        get :show, params: { id: service.id }

        expect(flash[:error]).to eq('Serviço não encontrado!')
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'destroy service' do
    context 'when user is authenticated and owner of service' do
      let(:service) { create(:service) }

      before do
        sign_in service.establishment.user

        delete :destroy, params: {
          establishment_id: service.establishment.id,
          id: service.id
        }
      end

      it 'show notice message and redirect to dashboard' do
        expect(flash[:notice]).to eq('Serviço arquivado!')
        expect(response).to redirect_to(
          establishments_dashboard_path(service.establishment)
        )
      end

      it 'update service to archived' do
        service.reload
        expect(service.status).to eq('archived')
      end
    end

    context 'when user is authenticated, but is not owner of service' do
      it 'show error message and redirect to home page' do
        service = create(:service)
        sign_in create(:user)

        delete :destroy, params: {
          establishment_id: service.establishment.id,
          id: service.id
        }

        expect(response).to have_http_status(:found)
        expect(flash[:error]).to eq('Não autorizado')
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        delete :destroy, params: { establishment_id: 0, id: 0 }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end
  end
end