module Admin
  class AdminController < ApplicationController
    include Pagy::Backend
    before_action :admin?

    private

    def admin?
      return if current_user.admin?

      flash[:error] = 'Não autorizado'
      redirect_to(root_path)
    end
  end
end
