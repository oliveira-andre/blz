# frozen_string_literal: true

class BuildScheduleJob < ApplicationJob
  queue_as :critical

  def perform(professional)
    BuildScheduleService.execute professional
  end
end
