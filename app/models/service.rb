class Service < ApplicationRecord
  enum status: %i[approved recused awaiting_avaliation archived]
  enum local_type: %i[home establishment both]

  has_many_attached :photos

  belongs_to :category
  belongs_to :establishment

  has_many :professional_services
  has_many :professionals, through: :professional_services

  validates :title, presence: true
  validates :title, uniqueness: { scope: :establishment_id }
  validates :description, presence: true
  validates :amount, presence: true
  validates :duration, presence: true
  validates :local_type, presence: true
  validates :status, presence: true

  validate :limit_number_photos
  validate :approving_service, on: :update

  def professionals_to_link
    professionals_ids = ProfessionalService.where(service_id: id)
                                           .pluck(:professional_id)

    Professional.where(establishment_id: establishment_id)
                .where.not(id: professionals_ids)
  end

  def update_and_rebuild_schedule(params)
    params = params.to_h
    duration_changed = duration != params[:duration].to_i
    updated = update(params)
    rebuild_schedule if duration_changed && updated
    updated
  end

  def self.search(query)
    where('title ILIKE ?', "%#{query}%")
  end

  private

  def limit_number_photos
    errors.add(:photos, '5 no máximo.') if photos.count > 5
  end

  def rebuild_schedule
    professional_services.each { |p_s| Schedule.rebuild(p_s) }
  end

  def approving_service
    if approved? && professional_services.empty? &&
       Schedule.where(professional_service_id: professional_services.ids).empty?
      @errors.add(
        :service, 'não pode ser aprovado sem profissionais com agenda.'
      )
    end
  end
end
