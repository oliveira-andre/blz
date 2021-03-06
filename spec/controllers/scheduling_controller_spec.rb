# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  describe 'new scheduling' do
    context 'when user is blocked' do
      it 'redirect to root page, not login and show error' do
        sign_in create(:blocked_user)
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
      let(:professional_service) { create(:professional_service) }

      context 'when user is a establishment' do
        it 'should redirect to root path and show error' do
          sign_in professional_service.service.establishment.user
          get :new, params: {
            date: date,
            professional_service_id: professional_service.id
          }
          expect(response).to have_http_status(:found)
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "user registration isn't ok" do
        it 'redirect to complete registration page' do
          sign_in create(:user)
          get :new, params: {
            date: date,
            professional_service_id: professional_service.id
          }
          expect(response).to redirect_to(
            edit_service_users_pt_br_path(
              service_id: professional_service.service.id,
              date: date,
              professional_service_id: professional_service.id
            )
          )
        end
      end

      context 'when user registration is ok!' do
        it 'render page to create scheduling' do
          sign_in create(:completed_user)
          get :new, params: {
            date: date,
            professional_service_id: professional_service.id
          }
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
      let(:schedule) { create(:schedule_in_establishment) }

      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in create(:blocked_user)
          get :create
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is a estabishment' do
        it 'redirect to root page and show error message' do
          sign_in schedule.professional_service.service.establishment.user
          params = {
            scheduling: {
              professional_service_id: schedule.professional_service.id,
              date: schedule.date,
              in_home: 0
            }
          }
          post :create, params: params
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "user registration isn't ok" do
        it 'redirect to root page and show error' do
          sign_in create(:user)
          params = {
            scheduling: {
              professional_service_id: schedule.professional_service.id,
              date: schedule.date,
              in_home: 0
            }
          }
          post :create, params: params
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when date in the past' do
        it 'show error message staying in the same page' do
          sign_in create(:completed_user)

          travel_to schedule.date + 1.month
          post :create, params: {
            scheduling: {
              professional_service_id: schedule.professional_service.id,
              date: schedule.date,
              in_home: 0
            }
          }
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
          sign_in create(:completed_user)

          post :create, params: {
            scheduling: {
              professional_service_id: schedule.professional_service.id,
              date: (schedule.date + 1.month),
              in_home: 0
            }
          }
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
          @scheduling = create(:scheduling)
          sign_in create(:completed_user)

          post :create, params: {
            scheduling: {
              professional_service_id: @scheduling.professional_service.id,
              date: @scheduling.date,
              in_home: @scheduling.in_home
            }
          }
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
            user = create(:completed_user)
            sign_in user
            params = {
              scheduling: {
                professional_service_id: schedule.professional_service.id,
                date: schedule.date,
                in_home: 0
              }
            }
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
            sign_in create(:completed_user)

            post :create, params: {
              scheduling: {
                professional_service_id: schedule.professional_service.id,
                date: schedule.date,
                in_home: 1
              }
            }
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
            sign_in create(:completed_user)
            home_schedule = create(:schedule_in_home)

            post :create, params: {
              scheduling: {
                professional_service_id: home_schedule.professional_service.id,
                date: home_schedule.date,
                in_home: 1,
                address_attributes: { street: '' }
              }
            }
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
            user = create(:completed_user)
            sign_in user
            home_schedule = create(:schedule_in_home)

            post :create, params: {
              scheduling: {
                professional_service_id: home_schedule.professional_service.id,
                date: home_schedule.date,
                in_home: 1,
                address_attributes: {
                  zipcode: '76807152',
                  street: 'teste',
                  neighborhood: 'teste',
                  number: '4135'
                }
              }
            }
            expect(response).to redirect_to(
              users_dashboard_pt_br_path(id: user.id)
            )
            expect(flash[:success]).to eq('Agendamento realizado com sucesso!')
          end
        end
      end
    end
  end

  describe 'show scheduling' do
    let(:scheduling) { create(:scheduling) }

    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        get :show, params: {
          id: scheduling.id
        }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          sign_in create(:blocked_user)
          get :show, params: {
            id: scheduling.id
          }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user isn't the establishment or user of scheduling" do
        it 'show error and be redirected to root_path' do
          sign_in create(:user)
          get :show, params: { id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when user is the establishment of scheduling' do
        it 'show the scheduling with success' do
          sign_in scheduling.professional_service.service.establishment.user
          get :show, params: {
            id: scheduling.id
          }
          expect(flash[:error]).to eq(nil)
          expect(assigns(:scheduling)).not_to be_nil
          expect(assigns(:report)).not_to be_nil
          expect(response).to have_http_status(:successful)
        end
      end

      context 'when user is the user of scheduling' do
        it 'show the scheduling with success' do
          sign_in scheduling.user
          get :show, params: {
            id: scheduling.id
          }
          expect(flash[:error]).to eq(nil)
          expect(assigns(:scheduling)).not_to be_nil
          expect(assigns(:report)).not_to be_nil
          expect(response).to have_http_status(:successful)
        end
      end
    end
  end

  describe 'destroy scheduling' do
    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        scheduling = create(:scheduling)
        delete :destroy, params: { id: scheduling.id }
        expect(flash[:alert]).to eq(
          'Para continuar, efetue login ou registre-se.'
        )
        expect(response).to redirect_to(new_user_session_pt_br_path)
      end
    end

    context 'when user is authenticated' do
      context 'when user is blocked' do
        it 'redirect to root page, not login and show error' do
          scheduling = create(:scheduling)
          sign_in create(:blocked_user)
          delete :destroy, params: { id: scheduling.id }
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context "when user don't have relation with scheduling" do
        it 'show error and redirect to root_path' do
          scheduling = create(:scheduling)
          sign_in create(:user)
          delete :destroy, params: { id: scheduling.id }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when try to cancel after the scheduling date' do
        it 'show error and stay in the same page' do
          scheduling = create(:scheduling)
          travel_to scheduling.date + 1.hour
          sign_in scheduling.user
          delete :destroy, params: {
            id: scheduling.id,
            scheduling: {
              canceled_reason: FFaker::BaconIpsum.sentence
            }
          }
          expect(flash[:error]).to eq(
            'Agendamento não pode ser cancelado após a data combinada'
          )
          scheduling.reload
          expect(scheduling.status).not_to eq('canceled')
          expect(response).to redirect_to(scheduling_pt_br_path(scheduling.id))
        end
      end

      context 'canceling as a establishment' do
        it 'cancel with success and not block the user' do
          scheduling = create(:scheduling)
          sign_in scheduling.professional_service.service.establishment
                            .user
          delete :destroy, params: {
            id: scheduling.id,
            scheduling: {
              canceled_reason: FFaker::BaconIpsum.sentence
            }
          }
          expect(flash[:error]).to eq(nil)
          expect(flash[:success]).to eq('Agendamento cancelado com sucesso')
          expect(scheduling.user.status).not_to eq('blocked')
          scheduling.reload
          expect(scheduling.status).to eq('canceled')
          expect(
            scheduling.professional_service.service.establishment.user
                                                                       .status
          ).not_to eq('blocked')
          expect(response).to redirect_to(
            scheduling_pt_br_path(scheduling)
          )
        end
      end

      context 'canceling as a user falting at least 4 hours to scheduling' do
        it 'cancel the scheduling with success and block user' do
          scheduling = create(:scheduling)
          travel_to scheduling.date - 3.hour
          sign_in scheduling.user
          delete :destroy, params: {
            id: scheduling.id,
            scheduling: {
              canceled_reason: FFaker::BaconIpsum.sentence
            }
          }
          expect(flash[:error]).to be_nil
          expect(flash[:success]).to eq('Agendamento cancelado com sucesso')
          scheduling.reload
          expect(scheduling.status).to eq('canceled')
          expect(scheduling.user.status).to eq('blocked')
          expect(response).to redirect_to(
            scheduling_pt_br_path(scheduling)
          )
        end
      end

      context 'canceling as a user falting more than 4 hours to scheduling' do
        it 'cancel the scheduling with success and block user' do
          scheduling = create(:scheduling)
          travel_to scheduling.date - rand(8..15).hours
          sign_in scheduling.user
          delete :destroy, params: {
            id: scheduling.id,
            scheduling: {
              canceled_reason: FFaker::BaconIpsum.sentence
            }
          }
          expect(flash[:error]).to eq(nil)
          expect(flash[:success]).to eq('Agendamento cancelado com sucesso')
          scheduling.reload
          expect(scheduling.status).to eq('canceled')
          expect(scheduling.user.status).not_to eq('blocked')
          expect(response).to redirect_to(
            scheduling_pt_br_path(scheduling)
          )
        end
      end
    end
  end
end
