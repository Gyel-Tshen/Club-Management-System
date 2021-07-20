class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :show, :update]
    def index
      @users = User.all.order(created_at: :desc)
      authorize @users
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
      
    end

    def update
      authorize @users
      if @user.update(user_params)
        redirect_to users_path, notice: "User role was successfully updated."
      else
        render :show
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
  
      if @user.destroy
          redirect_to root_url, notice: "User deleted."
      end
    end



    private

    def set_user
      @user = User.find(params[:id])

    end

    def user_params
      params.require(:user).permit({role_ids: []})
    end
end
  