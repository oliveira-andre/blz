# frozen_string_literal: true

class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(scheduling)
    notification_name = "notification:#{scheduling.service.establishment
                                                  .user.email}"
    date = "#{I18n.l(scheduling.date, format: :day_month)} às " \
           "#{I18n.l(scheduling.date, format: :time)}"

    ActionCable.server.broadcast notification_name,
                                 message: "Novo agendamento para #{date}"
  end
end
