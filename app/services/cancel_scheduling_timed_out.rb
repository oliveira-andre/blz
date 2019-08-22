module CancelSchedulingTimedOut
  class << self
    def execute
      schedulings = Scheduling.analyze
      schedulings.each do |scheduling|
        if Time.now > scheduling.date
          scheduling.update(
            status: :canceled, canceled_at: Time.now, canceled_by: 1,
            canceled_reason: canceled_sentece
          )
          scheduling.professional_service.service.establishment.user.blocked!
        end
      end
    end

    def canceled_sentece
      'Cancelado pelo sistema, devido ter passado da data combinada'
    end
  end
end
