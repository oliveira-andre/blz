class HoldersController < ApplicationController
  before_action :load_scheduling

  def new
    @holder = @scheduling.user
  end

  def update
    @scheduling.user.update!(holder_params)
    Address.update_or_create(@scheduling.user, address_params)

    redirect_to new_scheduling_payment_path(scheduling_id: @scheduling.id)
  rescue ActiveRecord::RecordInvalid => error
    @holder = @scheduling.user
    @messages_errors = error.record.errors.full_messages
    render 'new'
  end

  private

  def holder_params
    params.require(:user)
          .permit(:cpf, :phone, :birth_date)
  end

  def address_params
    params.require(:user).require(:address).permit(
      :street, :number, :neighborhood, :zipcode
    ).merge(addressable: @scheduling.user)
  end

  def load_scheduling
    @scheduling = Scheduling.waiting_paid.find(params[:scheduling_id])
  end
end