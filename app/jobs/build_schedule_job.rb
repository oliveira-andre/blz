class BuildScheduleJob < ApplicationJob
  queue_as :schedule

  def perform(professional_service)
    BuildScheduleService.execute professional_service
  end
end
