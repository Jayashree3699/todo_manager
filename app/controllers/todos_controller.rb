class TodosController < ApplicationController  
    protect_from_forgery except: :index
    def index    
        #render plain: Todo.order(:due_date).all.map {|todo| todo.to_pleasant_string}.join("\n") 
        render "index"
    end

    def show
        id = params[:id]
        todo = Todo.of_user(current_user).find(id)
        render plain: todo.to_pleasant_string
    end   
    
    def create
        todo_text = params[:todo_text]
        due_date = params[:due_date]
        new_todo = Todo.new(
            user_id: @current_user.id,
            todo_text: todo_text,
            due_date: due_date,
            completed: false,
        )
        if new_todo.save
            flash[:success] = "Added"
        else  
            flash[:error] = new_todo.errors.full_messages.join(", ")  
        end    
        #response_text = "todo created #{new_todo.id}"
       # render plain: response_text
       redirect_to todos_path
    end   

    def new
        render "new-todo"
    end 
    
    def update
        id = params[:id]
        completed = params[:completed]
        todo = Todo.find(id)
        todo.completed = completed
        todo.save
        redirect_to todos_path
    end  
    
    def destroy
        id = params[:id]
        todo = Todo.find(id)
        todo.destroy
        redirect_to todos_path
    end    
end