class SchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Solicitação de agendamento'
  end

  def to_contact(scheduling)
    @scheduling = scheduling

    mail to: 'contato@blz.life',
         subject: 'BLZ - há uma atualização sobre um agendamento'
  end
end
