module Admin
  class UsersController < AdminController
    def index
      @users = User.search(params[:search]) ||  User.all
      @pagy, @users = pagy(@users)
    end
  end
end