# frozen_string_literal: true

class SchedulingReminderJob < ApplicationJob
  queue_as :critical

  def perform
    SchedulingReminderService.execute
  end
end
