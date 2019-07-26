# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  describe 'new scheduling' do
    context 'when user is blocked' do
      it 'redirect to root page, not login and show error' do
        sign_in FactoryBot.create(:blocked_user)
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
      let(:date) { DateTime.now }
      let(:professional_service) { FactoryBot.create(:professional_service) }

      context 'when user is a estabishment' do
        it 'should redirect to root path and show error' do
          sign_in professional_service.service.establishment.user
          get :new, params: { date: date,
                              professional_service_id: professional_service.id }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "user registration isn't ok" do
        it 'redirect to complete registration page' do
          sign_in FactoryBot.create(:user)
          get :new, params: { date: date,
                              professional_service_id: professional_service.id }
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
                              professional_service_id: professional_service.id }
          expect(response).to have_http_status(:successful)
        end
      end
    end
  end

  describe 'create scheduling' do
    context 'when user is authenticated' do
      let(:schedule) { FactoryBot.create(:schedule) }

      context 'when user is a estabishment' do
        it 'redirect to root page and show error message' do
          sign_in schedule.professional_service.service.establishment.user
          params = { scheduling:
                      { professional_service_id: schedule.professional_service
                                                         .id,
                        date: schedule.date, in_home: 0 } }
          post :create, params: params
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "user registration isn't ok" do
        it 'redirect to root page and show error' do
          sign_in FactoryBot.create(:user)
          params = { scheduling:
                      { professional_service_id: schedule.professional_service
                                                         .id,
                        date: schedule.date, in_home: 0 } }
          post :create, params: params
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when date in the past' do
        it 'show error message staying in the same page' do
          sign_in FactoryBot.create(:completed_user)

          travel_to schedule.date + 1.month
          post :create, params: { scheduling: {
            professional_service_id: schedule.professional_service.id,
            date: schedule.date, in_home: 0
          } }
          expect(response).to redirect_to(
            new_scheduling_pt_br_path(
              date: schedule.date,
              professional_service_id: schedule.professional_service.id
            )
          )
          expect(flash[:error]).to eq('Horário não pode ser no passado')
        end
      end

      context 'when user registration is ok' do
        it 'create the scheduling with success' do
          user = FactoryBot.create(:completed_user)
          sign_in user
          params = { scheduling:
                    { professional_service_id: schedule.professional_service.id,
                      date: schedule.date, in_home: 0 } }
          post :create, params: params
          expect(response).to redirect_to(
            users_dashboard_pt_br_path(id: user.id)
          )
          expect(flash[:error]).to eq(nil)
          expect(flash[:success]).to eq('Agendamento realizado com sucesso!')
        end
      end
    end
  end
end
