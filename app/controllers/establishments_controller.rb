class EstablishmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :load_establishment, only: %i[edit update success]

  def new
    @establishment = Establishment.new
    @establishment.address = Address.new
    @establishment.user = User.new
  end

  def create
    @establishment = Establishment.new establishment_params
    @establishment.save!

    redirect_to establishments_dashboard_path(@establishment),
                notice: 'Cadastro realizado com sucesso'
  rescue ActiveRecord::RecordInvalid => error
    @messages_errors = error.record.errors.full_messages
    render 'new'
  end

  def edit; end

  def update
    @address.update edit_establishment_params[:address_attributes]
    @user.update edit_establishment_params[:user_attributes]
    redirect_to establishments_dashboard_path(@establishment),
                notice: 'Atualização realizada com sucesso'
  rescue ActiveRecord::RecordInvalid => error
    @errors = error.record.errors
    render 'new'
  end

  private

  def establishment_params
    params.require(:establishment)
          .permit(
            :name, :timetable, :photo, :self_employed, address_attributes: %i[
              street number neighborhood zipcode
            ], user_attributes: %i[
              name cpf email phone terms_acceptation birth_date
            ]
          )
  end

  def edit_establishment_params
    params.require(:establishment)
          .permit(
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