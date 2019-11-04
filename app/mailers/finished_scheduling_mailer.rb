class FinishedSchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - O agendamento foi finalizado'
  end

  def to_user(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.user.email,
         subject: 'BLZ - Seu agendamento foi finalizado'
  end
end