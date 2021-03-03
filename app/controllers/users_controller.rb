class UsersController < ApplicationController
    skip_before_action :ensure_logged_in
    def new
        render "new"
    end    

    def create
        user = User.new(
            first_name: params[:first_name],
            last_name: params[:last_name],
            email: params[:email],  
            password: params[:password]
        )
        if user.save
            flash[:success] = "successfully signed-up. Please signin to continue"
            redirect_to "/"
        else  
            flash[:error] = user.errors.full_messages.join(", ")
            redirect_to new_user_path   
        end   
        
    end
end    
