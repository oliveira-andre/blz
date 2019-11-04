class RebuildAllSchedulesJob < ApplicationJob
  queue_as :critical

  def perform
    RebuildAllSchedulesService.execute
  end
end
