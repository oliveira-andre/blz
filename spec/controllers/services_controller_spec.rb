# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::ServicesController, type: :controller do

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
        expect(service.status).to eql('archived')
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