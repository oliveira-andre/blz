module Admin
  class UsersController < AdminController
    def index
      if params[:search]
        @users = User.search(params[:search])
      else
        @users = User.all
      end
      @pagy, @users = pagy(@users)
    end
  end
end