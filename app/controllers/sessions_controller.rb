class SessionsController < ApplicationController

    skip_before_action :ensure_logged_in

    def new
        render "new"
    end    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:current_user_id] = user.id
            redirect_to todos_path
        else
            flash[:error] = "Invalid Credentials. Please Try Again"
            redirect_to "/"
        end    
    end  
    
    def destroy
        session[:current_user_id] = nil
        @current_user = nil
        redirect_to "/"
    end    
end    