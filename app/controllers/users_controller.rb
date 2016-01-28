class UsersController < ApplicationController
	def new
	  @users = User.new
	end

	 def index 
      @users = User.all
    end


	def create
	  @users = User.new(user_params)
	    if @users.save
	     flash[:success] = "Welcome to Alpha Blog #{@users.username}"
	     redirect_to articles_path
		else
         render 'new'
		end
	end

	def edit
	  @users = User.find(params[:id])
	end

	def update
		@users = User.find(params[:id])
		if @users.update(user_params)
  	  	  flash[:success] = "Your account was successfully updated"
  	  	  redirect_to articles_path
  	  	 else
  	  	   render 'edit'
	    end
    end

    def show 
    	@users = User.find(params[:id])
    end

	private 
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

end
