# frozen_string_literal: true

class AcceptedSchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - O agendamento foi aceito'
  end

  def to_user(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.user.email,
         subject: 'BLZ - Seu agendamento foi aceito'
  end

  def to_contact(scheduling)
    @scheduling = scheduling

    mail to: 'contato@blz.life',
         subject: 'BLZ - há uma atualização sobre um agendamento'
  end
end
