class RecusedSchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - O agendamento foi recusado'
  end

  def to_user(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Seu agendamento foi recusado'
  end
end
