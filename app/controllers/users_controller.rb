class UsersController < ApplicationController
	
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
	  @users = User.new
	end

	 def index 
      @users = User.paginate(page: params[:page], per_page: 5)
    end

	def create
	  @users = User.new(user_params)
	    if @users.save != User.new 
	     session[:user_id] = @users.id
	     flash[:success] = "Welcome to Alpha Blog, #{@users.username}"
	     redirect_to users_path(@users)
		elsif 
         @users.save 
         flash[:success] = "Welcome back #{@users.username}"
         redirect_to articles_path
		else 
			render 'new'
		end
	end

	def edit
	end

	def update
		if @users.update(user_params)
  	  	  flash[:success] = "Your account was successfully updated"
  	  	  redirect_to articles_path
  	  	 else
  	  	   render 'edit'
	    end
    end

    def show 
    	@users_articles = @users.articles.paginate(page: params[:page], per_page: 5)
    end

	private 
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user 
		@users = User.find(params[:id])
	end

	def require_same_user 
		if  current_user != @user 
			flash[:danger] = "You can only edit or update your own account"
			redirect_to user_path 
		end 

	end
end
