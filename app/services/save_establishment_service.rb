module SaveEstablishmentService
  class << self
    def execute establishment
      User.transaction do
        establishment.user.name = establishment.name
        establishment.user.email = establishment.email
        establishment.user.save!
        Establishment.transaction do
          establishment.save!
          Address.transaction do
            establishment.address.save!
          end
        end
      end
    end
  end
end