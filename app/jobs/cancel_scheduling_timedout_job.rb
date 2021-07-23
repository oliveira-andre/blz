# frozen_string_literal: true

class CancelSchedulingTimedOutJob < ApplicationJob
  queue_as :critical

  def perform
    RebuildAllSchedulesService.execute
  end
end
