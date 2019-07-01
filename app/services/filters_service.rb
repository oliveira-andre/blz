module FiltersService
  class << self
    def execute(filter_params)
      query = filter_params.fetch('query', '')
      date = filter_params.fetch('date', '')
      category = filter_params.fetch('category', '')
      local_type = filter_params.fetch('local_type', [])

      services = Service.approved
      services.where!(local_type: local_type) if local_type.present?
      services.where!('title ILIKE ?', "%#{query}%") if query.present?
      services.where!(category_id: category) if category.present?

      apply_date_filter(services, date) if date.present?
      services
    end

    private

    def apply_date_filter(services, date)
      return if services.empty?

      professional_services = ProfessionalService.where(
        service_id: services.ids
      )

      professional_services_ids = Schedule.where(
        professional_service_id: professional_services.ids,
        date: date.to_date.all_day,
        free: true
      ).pluck(:professional_service_id).uniq

      services_ids = professional_services.where(
        id: professional_services_ids
      ).pluck(:service_id).uniq

      services.where!(id: services_ids)
    end
  end
end
