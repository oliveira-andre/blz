# frozen_string_literal: true

class EstablishmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create show]
  before_action :load_establishment, only: %i[edit update success show]

  def show; end

  def new
    @establishment = Establishment.new
    @establishment.address = Address.new
    @establishment.user = User.new
    authorize @establishment
  end

  def create
    @establishment = Establishment.new establishment_params
    authorize @establishment
    @establishment.save!

    redirect_to feedbacks_path(email: @establishment.user.email)
  rescue ActiveRecord::RecordInvalid => e
    @messages_errors = e.record.errors.full_messages
    render 'new'
  end

  def edit
    authorize @establishment
  end

  def update
    authorize @establishment
    @establishment.update edit_establishment_params
    redirect_to edit_establishment_path(@establishment),
                notice: 'Atualização realizada com sucesso'
  rescue ActiveRecord::RecordInvalid => e
    @errors = e.record.errors
    render 'new'
  end

  private

  def establishment_params
    params.require(:establishment)
          .permit(
            :name, :timetable, :self_employed, address_attributes: %i[
              street number neighborhood zipcode
            ], user_attributes: %i[
              name cpf email phone terms_acceptation birth_date password
              password_confirmation
            ]
          )
  end

  def edit_establishment_params
    params.require(:establishment)
          .permit(
            :photo, :about,
            address_attributes: %i[id street number neighborhood zipcode],
            user_attributes: %i[id phone]
          )
  end

  def load_establishment
    @establishment = Establishment.find(params[:id] || params[:establishment_id])
    @user = User.find(@establishment.user_id)
    @address = Address.find_by(addressable: @establishment)
  end
end
