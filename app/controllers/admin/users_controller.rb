# frozen_string_literal: true

module Admin
  class UsersController < AdminController
    before_action :load_user, only: %i[show update]

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
    rescue ActiveRecord::RecordInvalid => e
      e.record.errors.full_messages.each { |error| flash[:error] = error }
      redirect_to admin_user_path(@service)
    end

    private

    def load_user
      @user = User.find(params[:id])
    end
  end
end
