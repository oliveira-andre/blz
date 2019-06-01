class Professional < ApplicationRecord
  belongs_to :establishment
  has_many :professional_services
  has_many :office_hours
  has_one_attached :photo

  validate :restrict_establishment

  private

  def restrict_establishment
    cont_arry = []
    cont_arry.push(establishment.user_id)
    if establishment.self_employed == 0
      errors.add(:base, 'Apenas um profissional!') if cont_arry.length == 1
    end
  end
end
