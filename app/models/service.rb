class Service < ApplicationRecord
  enum status: %i[approved recused awaiting_avaliation archived]
  enum local_type: %i[home establishment]
  has_many_attached :photos
  belongs_to :category
  belongs_to :establishment
  has_many :professional_services
  has_many :professionals, through: :professional_services
  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
  validates :local_type, presence: true
  validates :status, :photos, presence: true
  validate :photos_type
  validates :title, uniqueness: {scope: :establishment_id}

  def professionals_to_link
    professionals_ids = ProfessionalService.where(service_id: id).pluck(:professional_id)
    Professional.where(establishment_id: establishment_id).where.not(id: professionals_ids)
  end

  def thumbmail_smal input
    return self.photos[input].variant(resize: "320x240!").processed
  end

  def thumbmail_full input
    return self.photos[input].variant(resize: "1280x960!").processed
  end

  private
  def photos_type
    object_array = []
    photos.each do |p|
      object_array.push(p)
    end
    if object_array.length > 5
      errors.add(:atenção!, 'Você deve inserir no máximo 5 fotos')
    end
    photos.each do |photo|
      if !photo.content_type.in?(%('image/jpeg image/png))
        errors.add(:"atenção!", 'Apenas fotos com extenção JPEG e PNG')
      end
    end
  end
end
