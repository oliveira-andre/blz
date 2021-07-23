# frozen_string_literal: true

module CancelSchedulingTimedOutService
  class << self
    def execute
      schedulings = Scheduling.analyze
      time = Time.now.utc - 4.hours
      schedulings.each do |scheduling|
        next unless time > scheduling.date

        scheduling.update(
          status: :canceled, canceled_at: time, canceled_by: 1,
          canceled_reason: 'Cancelado pelo sistema,'\
                            'devido ter passado da data combinada'
        )
        scheduling.professional_service.service.establishment.user.blocked!
      end
    end
  end
end
