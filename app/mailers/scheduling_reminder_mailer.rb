# frozen_string_literal: true

class SchedulingReminderMailer < ApplicationMailer
  def twenty_four_hours(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
         subject: 'BLZ - Lembrete do agendamento'
  end

  def four_hours(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.user.email,
         subject: 'BLZ - Lembrete do agendamento'
  end
end
