class BuildScheduleJob < ApplicationJob
  queue_as :critical

  def perform(professional_service)
    BuildScheduleService.execute professional_service
  end
end
