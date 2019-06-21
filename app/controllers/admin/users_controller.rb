# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :user, only: %i[show update]

    def index
      @users = if params[:search]
                 User.search(params[:search])
               else
                 User.all
               end
      @pagy, @users = pagy(@users)
    end

    def show; end

    def update
      @user.update(status: params[:status])
      redirect_to admin_users_path
      flash[:success] = if params[:status] == 'active'
                          'Ativado com sucesso'
                        else
                          'Bloqueado com sucesso'
                        end
    end

    private

    def user
      @user = User.find(params[:id])
    end
  end
end
