class SchedulingMailer < ApplicationMailer
  def to_user(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.user.email,
         subject: 'BLZ - Sobre seu agendamento'
  end

  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Novo agendamento'
  end
end
