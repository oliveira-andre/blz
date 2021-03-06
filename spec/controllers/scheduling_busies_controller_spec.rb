# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulingBusiesController, type: :controller do
  describe 'scheduling_busies create' do
    context "when user isn't authenticated" do
      it 'redirect to sign in' do
        post :create
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
          post :create
          expect(flash[:error]).to eq('Seu usuário está bloqueado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when trying to create busy scheduling in the past' do
        it 'show error and stay in the same page' do
          schedule = FactoryBot.create(:schedule)
          sign_in schedule.professional_service.service.establishment.user
          post :create, params: {
            establishment_id: schedule.professional_service.service
                                      .establishment.id,
            service_duration: rand(30..480),
            date_only: Time.now.strftime('%d/%m/%Y'),
            time: Time.now.strftime('%H:%M:%S'),
            professional_id: schedule.professional_service.professional.id
          }
          expect(flash[:error]).to eq('Horário não pode ser no passado')
          expect(response).to redirect_to(
            establishments_dashboard_pt_br_path(
              schedule.professional_service.service.establishment.id
            )
          )
        end
      end

      context 'when user is common' do
        it 'show error and redirect to root path' do
          schedule = FactoryBot.create(:schedule)
          sign_in FactoryBot.create(:user)
          post :create, params: {
            establishment_id: schedule.professional_service.service
                                      .establishment.id,
            service_duration: rand(30..480),
            date_only: schedule.date.strftime('%d/%m/%Y'),
            time: schedule.date.strftime('%H:%M:%S'),
            professional_id: schedule.professional_service.professional.id
          }
          expect(flash[:error]).to eq('Não autorizado')
          expect(response).to redirect_to(root_path)
        end
      end

      context 'establishment create a busy time to professional' do
        it 'create busy with success' do
          schedule = FactoryBot.create(:schedule)
          sign_in schedule.professional_service.service.establishment.user
          post :create, params: {
            establishment_id: schedule.professional_service.service
                                      .establishment.id,
            service_duration: rand(30..480),
            date_only: schedule.date.strftime('%d/%m/%Y'),
            time: schedule.date.strftime('%H:%M:%S'),
            professional_id: schedule.professional_service.professional.id
          }
          expect(flash[:success]).to eq('Período marcado como indisponível')
          expect(response).to redirect_to(
            establishments_dashboard_pt_br_path(
              schedule.professional_service.service.establishment.id
            )
          )
        end
      end
    end
  end
end
