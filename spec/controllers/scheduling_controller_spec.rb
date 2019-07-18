# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchedulingController, type: :controller do
  before(:each) do
    @schedule = FactoryBot.create(:schedule)
    @scheduling = FactoryBot.create(:scheduling)
    @current_user = FactoryBot.create(:completed_user)
    sign_in @current_user
  end

  # success

  describe 'visit new' do
    it 'returns http success' do
      get :new, params: { date: @schedule.date,
                          professional_service_id: @schedule
                            .professional_service.id }
      expect(response).to have_http_status(:successful)
    end
  end

  describe 'create scheduling' do
    it 'returns http success' do
      params = { scheduling:
                 { professional_service_id: @schedule.professional_service.id,
                   date: @schedule.date, in_home: 0 } }
      post :create, params: params
      expect(response).to have_http_status(:found)
      redirect_to(establishments_dashboard_path(
                    @schedule.professional_service.service.establishment
                  ))
      expect(flash[:error]).to eq(nil)
      expect(flash[:success]).to eq('Agendamento realizado com sucesso!')
    end
  end

  describe 'describe scheduling' do
    it 'returns http success' do
      sign_in @scheduling.user
      get :show, params: { id: @scheduling.id }
      expect(response).to have_http_status(:successful)
      expect(flash[:error]).to eq(nil)
    end
  end

  describe 'finish scheduling' do
    it 'returns http success' do
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

  describe 'cancel scheduling' do
    it 'returns http success' do
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

  # errors
  describe 'visit new' do
    it 'unlogged must be unnatorized' do
      sign_out @current_user
      get :new
      expect(response).to have_http_status(:found)
      expect(flash[:alert]).to eq(
        'Para continuar, efetue login ou registre-se.'
      )
    end

    it 'registration not ok must be redirected' do
      sign_in FactoryBot.create(:uncompleted_user)
      get :new, params: { date: @schedule.date,
                          professional_service_id: @schedule
                            .professional_service.id }
      expect(response).to have_http_status(:found)
    end

    it 'without params cannot construct the page' do
      sign_in FactoryBot.create(:uncompleted_user)
      expect { get :new }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'not create scheduling' do
    it 'falting params' do
      params = { scheduling: { date: @schedule.date, in_home: 0 } }
      expect { post :create, params: params }.to raise_error(NoMethodError)
    end

    it 'date in the past' do
      travel_to @schedule.date + 1.month
      post :create, params: { scheduling: {
        professional_service_id: @schedule.professional_service.id,
        date: @schedule.date, in_home: 0
      } }
      expect(flash[:error]).to eq('Horário não pode ser no passado')
    end
  end

  describe 'not finish scheduling' do
    it 'before the scheduling date' do
      travel_to @scheduling.date - 1.hour
      sign_in @scheduling.professional_service.service.establishment.user
      put :update, params: { id: @scheduling.id, status: :finished }
      expect(flash[:error]).to eq(
        'Agendamento não pode ser finalizado antes a data combinada'
      )
    end
  end

  describe 'not cancel scheduling' do
    it 'not have reason' do
      travel_to @scheduling.date - 1.hour
      sign_in @scheduling.user
      delete :destroy, params: { id: @scheduling.id, scheduling: {
        canceled_reason: ''
      } }
      expect(flash[:error]).to eq('Justificativa não pode ficar em branco')
    end

    it 'after the scheduling date' do
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
end
