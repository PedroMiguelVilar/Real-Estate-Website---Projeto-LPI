class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def login
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to index_path, notice: "Logged in!"
        else
          flash.now.alert = "Email or password is invalid"
          render "login"
        end
    end
      


    def logout
        session[:user_id] = nil
        redirect_to root_url, notice: "Logged out!"
      end


    def require_login
      unless session[:user_id]
        redirect_to login_path, alert: "You must be logged in to access this page"
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to index_path, notice: "Thanks for signing up!"
      else
        render :new
      end
    end
      
    
    private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
      
  end
  