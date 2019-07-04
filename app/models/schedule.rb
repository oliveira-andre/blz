class Schedule < ApplicationRecord
  belongs_to :professional_service

  before_save :verify_busy

  def self.rebuild(professional_service)
    BuildScheduleJob.perform_later(professional_service)
  end

  private

  def verify_busy
    scheduling = professional_service.scheduling.where(
      date: date..(date + professional_service.service.duration - 1.seconds)
    ).scheduled.first

    self.free = scheduling.nil?
  end
end
