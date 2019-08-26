module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show; end

    private

    def after_confirmation_path_for(resource_name, resource)
      debugger
    end
  end
end
