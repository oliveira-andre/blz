class SchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Solicitação agendamento'
  end
end
