class PaymentsController < ApplicationController
  before_action :load_scheduling

  def new; end

  def create
    Moip::Order::CreateService.execute(@scheduling)
    p = Moip::Payment::CreateService.execute(
      @scheduling.moip_order_id,
      credit_card_params
    )

    redirect_to users_dashboard_path(current_user), notice: 'Agendamento realizado com sucesso!'
  end

  private

  def credit_card_params
    params.permit(:installment_count, :card_hash, :fullname, :birth_date, :cpf)
  end

  def load_scheduling
    @scheduling = Scheduling.waiting_paid.find(params[:scheduling_id])
  end
end