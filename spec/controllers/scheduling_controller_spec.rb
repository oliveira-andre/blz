# frozen_string_literal: true

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

  describe 'create scheduling' do
    context 'when user is authenticated' do
      context 'when user is a estabishment' do
        it 'should redirect to root page and show error message' do
          sign_in @scheduling.service.establishment.user
          params = { scheduling:
                      { professional_service_id: @schedule.professional_service.id,
                        date: @schedule.date, in_home: 0 } }
          post :create, params: params
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
        end
      end

      context "user registration isn't ok" do
        it 'should redirect to root page and show error' do
          sign_in FactoryBot.create(:uncompleted_user)
          params = { scheduling:
                      { professional_service_id: @schedule.professional_service.id,
                        date: @schedule.date, in_home: 0 } }
          post :create, params: params
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
        end
      end

      context 'when date in the past' do
        it 'should show error message' do
          travel_to @schedule.date + 1.month
          post :create, params: { scheduling: {
            professional_service_id: @schedule.professional_service.id,
            date: @schedule.date, in_home: 0
          } }
          expect(flash[:error]).to eq('Horário não pode ser no passado')
        end
      end

      context 'when user registration is ok' do
        it 'create the scheduling with success' do
          params = { scheduling:
                    { professional_service_id: @schedule.professional_service.id,
                      date: @schedule.date, in_home: 0 } }
          post :create, params: params
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq(nil)
          expect(flash[:success]).to eq('Agendamento realizado com sucesso!')
        end
      end
    end
  end

  describe 'show scheduling' do
    context 'when user is authenticated' do
      context 'user that not made the scheduling' do
        it 'should redirect and show error' do
          get :show, params: { id: @scheduling.id }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
        end
      end

      context 'user that made the scheduling' do
        it 'should describe the scheduling with success' do
          sign_in @scheduling.user
          get :show, params: { id: @scheduling.id }
          expect(response).to have_http_status(:successful)
          expect(flash[:error]).to eq(nil)
        end
      end

      context 'establishment that have the scheduling' do
        it 'should describe the scheduling with success' do
          sign_in @scheduling.service.establishment.user
          get :show, params: { id: @scheduling.id }
          expect(response).to have_http_status(:successful)
          expect(flash[:error]).to eq(nil)
        end
      end
    end
  end

  describe 'cancel scheduling' do
    context 'when user is authenticated' do
      context 'not have reason' do
        it 'should show error' do
          travel_to @scheduling.date - 1.hour
          sign_in @scheduling.user
          delete :destroy, params: { id: @scheduling.id, scheduling: {
            canceled_reason: ''
          } }
          expect(flash[:error]).to eq('Justificativa não pode ficar em branco')
        end
      end

      context 'after the scheduling date' do
        it 'should show error' do
          travel_to @scheduling.date + 1.hour
          sign_in @scheduling.user
          delete :destroy, params: { id: @scheduling.id, scheduling: {
            canceled_reason: FFaker::Lorem.sentence
          } }
          expect(flash[:error]).to eq(
            'Agendamento não pode ser cancelado após a data combinada'
          )
        end
      end

      context 'before the date in scheduling' do
        it 'should cancel with sucess' do
          travel_to @scheduling.date - 1.hour
          sign_in @scheduling.user
          delete :destroy, params: { id: @scheduling.id, scheduling: {
            canceled_reason: FFaker::Lorem.sentence
          } }
          expect(response).to have_http_status(:found)
          redirect_to scheduling_path(@scheduling)
          expect(flash[:error]).to eq(nil)
          expect(flash[:success]).to eq('Agendamento cancelado com sucesso')
        end
      end
    end
  end

  describe 'finish scheduling' do
    context 'when user is authenticated' do
      context "user isn't a establishment" do
        it 'should redirect to root page and show error' do
          travel_to @scheduling.date + 1.hour
          sign_in @scheduling.user
          put :update, params: { id: @scheduling.id, status: :finished }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
        end
      end

      context 'user is a establishment' do
        context 'before the scheduling date' do
          it 'should show error' do
            travel_to @scheduling.date - 1.hour
            sign_in @scheduling.professional_service.service.establishment.user
            put :update, params: { id: @scheduling.id, status: :finished }
            expect(flash[:error]).to eq(
              'Agendamento não pode ser finalizado antes a data combinada'
            )
          end
        end

        context 'after the scheduling date' do
          it 'should finish with success' do
            travel_to @scheduling.date + 1.hour
            sign_in @scheduling.professional_service.service.establishment.user
            put :update, params: { id: @scheduling.id, status: :finished }
            expect(response).to have_http_status(:found)
            redirect_to establishments_dashboard_path(
              @scheduling.professional_service.service.establishment
            )
            expect(flash[:error]).to eq(nil)
            expect(flash[:success]).to eq('Finalizado com sucesso')
          end
        end
      end
    end
  end
end
