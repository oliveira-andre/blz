# frozen_string_literal: true

class CanceledSchedulingMailer < ApplicationMailer
  def to_establishment(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Agendamento cancelado'
  end

  def to_user(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.user.email,
         subject: 'BLZ - Sobre seu agendamento'
  end
end
