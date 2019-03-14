class LinkedService < ApplicationRecord
  belongs_to :service
  belongs_to :linked, class_name: 'Service', foreign_key: 'linked_id'

  validate :services_already_linked

  private

  def services_already_linked
    ids = [service_id, linked_id]
    return unless LinkedService.where(service_id: ids, linked_id: ids).any?

    @errors.add(:service, 'já esta vinculado com esse serviço')
  end
end
