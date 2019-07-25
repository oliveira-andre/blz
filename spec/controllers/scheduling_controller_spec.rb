require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  before(:each) do
    @schedule = FactoryBot.create(:schedule)
    @scheduling = FactoryBot.create(:scheduling)
    @current_user = FactoryBot.create(:completed_user)
    sign_in @current_user
  end

  describe 'new scheduling' do
    context 'when user is blocked' do
      it 'should redirect to root page, not login and show error' do
        sign_out @current_user
        @current_user.blocked!
        sign_in @current_user
        get :new
        expect(flash[:error]).to eq('Seu usuário está bloqueado')
      end
    end

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        sign_out @current_user
        get :new
        expect(response).to have_http_status(:found)
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
      end
    end

    context 'when user is authenticated' do
      context 'when user is a estabishment' do
        it 'should redirect to root path and show error' do
          sign_in @scheduling.service.establishment.user
          get :new, params: { date: @schedule.date,
                              professional_service_id: @schedule
                                .professional_service.id }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
        end
      end

      context "user registration isn't ok" do
        it 'redirect to complete registration page' do
          sign_in FactoryBot.create(:uncompleted_user)
          get :new, params: { date: @schedule.date,
                              professional_service_id: @schedule
                                .professional_service.id }
          expect(response).to have_http_status(:found)
        end
      end

      context 'when user registration is ok!' do
        it 'render page to create scheduling' do
          get :new, params: { date: @schedule.date,
                              professional_service_id: @schedule
                                .professional_service.id }
          expect(response).to have_http_status(:successful)
        end
      end
    end
  end
end