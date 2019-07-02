class Schedule < ApplicationRecord
  belongs_to :professional_service

  before_save :busy_role

  def self.rebuild(professional_service)
    BuildScheduleJob.perform_later(professional_service)
  end

  private

  def busy_role
    scheduling = professional_service.scheduling.where(
      date: date..(date + professional_service.service.duration - 1.seconds)
    ).first

    self.free = scheduling.nil? || scheduling&.canceled?
  end
end
