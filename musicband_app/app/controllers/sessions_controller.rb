class SessionsController < ApplicationController
   respond_to :html

   #Only activate this command in emmergencies.
   #before_filter :load_userchecker, :only =>[:new]

   #New is the action that causes a login box to appear for the user.
   def new
   end

   #Create is the action that causes you to be logged into your user account
   def create

      groupee = Groupee.find_by_username(params[:session][:username].downcase)
      if groupee && groupee.authenticate(params[:session][:password])
         #sets the current user's session and stores it
         session[:groupee_id] = groupee.id
         redirect_to groupee #Sign in the user and pull up users page
      else
         flash.now[:error] = 'Invalid username/password combination'
         render 'new'
      end
   end

   #Destroy is the action that causes you logout of your current session
   def destroy
      #resets the user's session upon successful logout
      session[:groupee_id] = nil
      redirect_to root_path, :notice => "Goodbye hope to see you soon"
   end

   private 

      #load_userchecker is an emmergency session clearing device for when a database gets deleted.
      def load_userchecker
         @groupee = Groupee.find_by_id(params[:id])
         #If both user is not nil and current_user is not nil then
         session[:groupee_id] = nil
         if ((!current_groupee.nil?) && (!@groupee.nil?))
            flash[:notice] = "I am not nil for user and current_user"
         else 
            if ((!current_groupee.nil?) && (@groupee))
               flash[:notice] = "I am nil for only the user"
               @user = nil
            else
               if((current_groupee.nil?) && (!@groupee))
                  flash[:notice] = "I am nil only for the current_user"
               else
                  flash[:notice] = "I am nil for both the current_user and the regular user"
               end
            end
         end
      end
end
