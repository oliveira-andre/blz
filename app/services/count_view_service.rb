# frozen_string_literal: true

module CountViewService
  class << self
    def execute(service)
      if service.view.present?
        viewable = service.view
        viewable.update(viewable_count: (viewable.viewable_count + 1))
      else
        View.create(viewable: service)
      end
    end
  end
end
