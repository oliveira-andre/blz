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
    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        get :create
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

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

      context "when date isn't on schedule" do
        it 'show error message staying in the same page' do
          sign_in FactoryBot.create(:completed_user)

          post :create, params: { scheduling: {
            professional_service_id: schedule.professional_service.id,
            date: (schedule.date + 1.month), in_home: 0
          } }
          expect(response).to redirect_to(
            new_scheduling_pt_br_path(
              date: (schedule.date + 1.month),
              professional_service_id: schedule.professional_service.id
            )
          )
          expect(flash[:error]).to eq(
            'Horário inválido ou indisponível, tente novamente'
          )
        end
      end

      context 'when professional already busy' do
        it 'show error message staying in the same page' do
          @scheduling = FactoryBot.create(:scheduling)
          sign_in FactoryBot.create(:completed_user)

          post :create, params: { scheduling: {
            professional_service_id: @scheduling.professional_service.id,
            date: @scheduling.date, in_home: 0
          } }
          expect(response).to redirect_to(
            new_scheduling_pt_br_path(
              date: @scheduling.date,
              professional_service_id: @scheduling.professional_service.id
            )
          )
          expect(flash[:error]).to eq(
            'Horário já esta ocupado para esse salão/profissional'
          )
        end
      end

      context "when isn't in home" do
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

      context 'when is in home' do
        context 'when the service not accept in home' do
          it 'show error and stay in the same page' do
            sign_in FactoryBot.create(:completed_user)

            post :create, params: { scheduling: {
              professional_service_id: schedule.professional_service.id,
              date: schedule.date, in_home: 1
            } }
            expect(response).to redirect_to(
              new_scheduling_pt_br_path(
                date: schedule.date,
                professional_service_id: schedule.professional_service.id
              )
            )
            expect(flash[:error]).to eq(
              'Serviço não permite essa localidade'
            )
          end
        end

        context 'without address' do
          it 'show error and stay in the same page' do
            sign_in FactoryBot.create(:completed_user)
            home_schedule = FactoryBot.create(:schedule_in_home)

            post :create, params: { scheduling: {
              professional_service_id: home_schedule.professional_service.id,
              date: home_schedule.date, in_home: 1,
              address_attributes: { street: '' }
            } }
            expect(response).to redirect_to(
              new_scheduling_pt_br_path(
                date: home_schedule.date,
                professional_service_id: home_schedule.professional_service.id
              )
            )
            expect(flash[:error]).to eq(
              'Bairro não pode ficar em branco'
            )
          end
        end

        context 'with address' do
          it 'create the scheduling with success' do
            user = FactoryBot.create(:completed_user)
            sign_in user
            home_schedule = FactoryBot.create(:schedule_in_home)

            post :create, params: { scheduling: {
              professional_service_id: home_schedule.professional_service.id,
              date: home_schedule.date, in_home: 1,
              address_attributes: {
                zipcode: '76807152', street: 'teste', neighborhood: 'teste',
                number: '4135'
              }
            } }
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

  describe 'show scheduling' do
    let(:scheduling) { FactoryBot.create(:scheduling) }

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        get :show, params: { id: scheduling.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in FactoryBot.create(:blocked_user)
          get :show, params: { id: scheduling.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user isn't the establishment or user of scheduling" do
        it 'show error and be redirected to root_path' do
          sign_in FactoryBot.create(:user)
          get :show, params: { id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is the establishment of scheduling' do
        it 'show the scheduling with success' do
          sign_in scheduling.professional_service.service.establishment.user
          get :show, params: { id: scheduling.id }
          expect(flash[:error]).to eq(nil)
          expect(assigns(:report)).not_to be_nil
        end
      end

      context 'when user is the user of scheduling' do
        it 'show the scheduling with success' do
          sign_in scheduling.user
          get :show, params: { id: scheduling.id }
          expect(flash[:error]).to eq(nil)
          expect(assigns(:report)).not_to be_nil
        end
      end
    end
  end
end
