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
      if params[:status] == 'active'
        @user.active!
        flash[:success] = 'Ativado com sucesso'
      end

      if params[:status] == 'blocked'
        @user.blocked!
        flash[:success] = 'Bloqueado com sucesso'
      end

      redirect_to admin_users_path
    end

    private

    def user
      @user = User.find(params[:id])
    end
  end
end
