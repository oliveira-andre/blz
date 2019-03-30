class Schedule < ApplicationRecord
  belongs_to :professional_service

  def self.rebuild(professional_service)
    BuildScheduleJob.perform_later(professional_service)
  end
end
