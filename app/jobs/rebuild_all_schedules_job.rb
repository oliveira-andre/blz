# frozen_string_literal: true

class RebuildAllSchedulesJob < ApplicationJob
  queue_as :critical

  def perform
    RebuildAllSchedulesService.execute
  end
end
