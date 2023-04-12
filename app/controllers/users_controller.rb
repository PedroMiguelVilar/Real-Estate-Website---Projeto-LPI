class UsersController < ApplicationController


  helper_method :sort_column, :sort_direction
  def favorites
    if current_user && current_user.id == params[:id].to_i
      @favorites = current_user.favorite_houses.paginate(page: params[:page], per_page: 9).order(sort_column + " " + sort_direction)
      @image_urls = PagesController.new.scrape(@favorites)
      @houses_map = current_user.favorite_houses
      render "favourites"
    else
      redirect_to root_path, alert: "You are not authorized to view this page"
    end
  end


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
    redirect_to index_url, notice: "Logged out!"
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
  def sort_column
    puts "params[:sort]: #{params[:sort_column]}"
    House.column_names.include?(params[:sort_column]) ? params[:sort_column] : "Id"
  end
  
  def sort_direction
    puts "params[:direction]: #{params[:sort_direction]}"
    %w[asc desc].include?(params[:sort_direction]) ? params[:sort_direction] : "asc"
  end
      
  end
  