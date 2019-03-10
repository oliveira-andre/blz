class EstablishmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :load_establishment, only: %i[edit update]

  def new
    @user = User.new
    @establishment = Establishment.new user: @user
    @address = Address.new establishment: @establishment
    @establishment.address = @address
  end

  def create
    @establishment = Establishment.new establishment_params
    @establishment.address = Address.new establishment_params[:address_attributes]
    @establishment.address.establishment = @establishment
    SaveEstablishmentService.execute @establishment
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => error
    @errors = error.record.errors
    render 'new'
  end

  def edit; end

  def update
    @establishment.update(
      establishment_params.except(:address_attributes, :user_attributes)
    )
    @address&.update establishment_params[:address_attributes]
    @user&.update establishment_params[:user_attributes]
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid => error
    @errors = error.record.errors
    render 'new'
  end

  private

  def establishment_params
    params.require(:establishment)
          .permit(:cpf_cnpj, :name, :email, :phone, :timetable, :photo,
                  address_attributes: %i[street number neighborhood zipcode],
                  user_attributes: %i[password password_confirmation])
  end

  def load_establishment
    @establishment = Establishment.find(params[:id])
    @user = User.find(@establishment.user_id)
    @address = Address.find_by(establishment: @establishment)
  end
end