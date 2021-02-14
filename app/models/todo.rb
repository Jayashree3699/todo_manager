class Todo < ActiveRecord::Base
    def to_pleasant_string
        is_completed = completed ? "[X]" : "[ ]"
        "#{id}. #{todo_text} #{due_date.to_s(:short)} #{is_completed}"
    end  
    
    def due_today?    
        due_date == Date.today  
    end  

    def self.overdue
        all.where("due_date < ?", Date.today)
        
    end

    def self.due_today
        all.where("due_date = ?", Date.today)
        
    end
    def self.due_later
        all.where("due_date > ?", Date.today)
        
    end

    def self.completed
        all.where(completed: true)
    end    
    ########################
    def to_displayable_string    
        display_status = completed ? "[X]" : "[ ]"    
        display_date = due_today? ? nil : due_date    
        "#{id} #{display_status} #{todo_text} #{display_date}"  
    end

    def self.to_displayable_list    
        all.map {|todo| todo.to_displayable_string }  
    end

    def check_date
        flag=0
        if due_today?
            flag=0
        elsif 
            flag=(due_date > Date.today )? 2:1  
        end  
        flag  
    end  

    def self.show_list
        over = Array.new
        today = Array.new
        later = Array.new
        all.each do |todo|
            flag=todo.check_date

            if flag==0
                today.push(todo.to_displayable_string)    
                
            else
                (flag.to_i==2)?(later.push(todo.to_displayable_string) ) :(over.push(todo.to_displayable_string) )
                
            end

                
        end 
        puts "Over Due"
        over.each do |over_due|
            puts over_due
        end

        puts "Due Today"
        today.each do |today_due|
            puts today_due
        end

        puts "Later Due"
        later.each do |later_due|
            puts later_due
        end



    end 


    def self.add_task(h)
        
        Todo.create!(todo_text: h[:todo_text], due_date: Date.today+h[:due_in_days].to_i, completed: false)
        #Todo.save

    end    

    def self.mark_as_complete!(todo_id)
        todo = Todo.where(id: todo_id.to_i)
        #puts todo.todo_text
        #todo.save
        todo

    end   

end    