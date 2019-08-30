class SchedulingReminder < ApplicationMailer
  def twenty_four_hours(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
    subject: 'BLZ - Lembrete do agendamento'
  end

  def four_hours(scheduling)
    @scheduling = scheduling

    mail to: @scheduling.service.establishment.user.email,
    subject: 'BLZ - Lembrete do agendamento'
  end
end