require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  describe 'new scheduling' do
    let(:date) { DateTime.now }
    let(:professional_service) { FactoryBot.create(:professional_service) }

    context 'when user is blocked' do
      before(:each) do
        @current_user = FactoryBot.create(:blocked_user)
        sign_in @current_user
      end

      it 'redirect to root page, not login and show error' do
        get :new
        expect(flash[:error]).to eq('Seu usuário está bloqueado')
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        get :new
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is a estabishment' do
        it 'should redirect to root path and show error' do
          sign_in professional_service.service.establishment.user
          get :new, params: { date: date,
                              professional_service_id: professional_service.id
                            }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "user registration isn't ok" do
        it 'redirect to complete registration page' do
          sign_in FactoryBot.create(:user)
          get :new, params: { date: date,
                              professional_service_id: professional_service.id
                            }
        expect(response).to redirect_to(
          edit_service_users_pt_br_path(
            service_id: professional_service.id,
            date: date,
            professional_service_id: professional_service.id
          )
        )
        end
      end

      context 'when user registration is ok!' do
        it 'render page to create scheduling' do
          sign_in FactoryBot.create(:completed_user)
          get :new, params: { date: date,
                              professional_service_id: professional_service.id
                            }
          expect(response).to have_http_status(:successful)
        end
      end
    end
  end
end