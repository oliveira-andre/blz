class EstablishmentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  before_action :load_establishment, only: %i[edit update success authorization]

  def new
    @establishment = Establishment.new
    @establishment.address = Address.new
    @establishment.user = User.new
  end

  def create
    @establishment = Establishment.new establishment_params
    @establishment.save!
    Moip::CreateAccountService.execute @establishment
    redirect_to establishments_dashboard_path(@establishment),
                notice: 'Cadastro realizado com sucesso'
  rescue ActiveRecord::RecordInvalid => error
    @messages_errors = error.record.errors.full_messages
    render 'new'
  end

  def edit; end

  def update
    @establishment.update(
      establishment_params.except(:address_attributes, :user_attributes)
    )
    @address&.update establishment_params[:address_attributes]
    @user&.update establishment_params[:user_attributes]
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
            :name, :timetable, :photo, address_attributes: %i[
              street number neighborhood zipcode
            ], user_attributes: %i[
              name cpf email phone password password_confirmation
              terms_acceptation birth_date
            ]
          )
  end

  def load_establishment
    @establishment = Establishment.find(params[:id] || params[:establishment_id])
    @user = User.find(@establishment.user_id)
    @address = Address.find_by(establishment: @establishment)
  end
end
