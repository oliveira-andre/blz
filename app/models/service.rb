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
  validates :status, presence: true

  validates :title, uniqueness: { scope: :establishment_id }

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

  private

  def rebuild_schedule
    professional_services.each { |p_s| Schedule.rebuild(p_s) }
  end
end
