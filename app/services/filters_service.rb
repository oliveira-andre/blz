module FiltersService
  class << self
    def execute(filter_params)
      query = filter_params.fetch('query', '')
      category_id = filter_params.fetch('category_id', '')
      local_type = filter_params.fetch('local_type', '')

      services = Service.approved
      services.where!(local_type: local_type) if local_type.present?
      services.where!('title ILIKE ?', "%#{query}%") if query.present?
      services.where!(category_id: category_id) if category_id.present?
      services
    end
  end
end
