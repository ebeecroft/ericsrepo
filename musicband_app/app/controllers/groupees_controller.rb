class GroupeesController < ApplicationController
   respond_to :html

   #filter finduser is only used with the actions :show, :edit and :update
   before_filter :load_findgroupee, :only => [:show, :edit, :update]

   #Admin Only Function that displays all the current users
   def index
      if (!current_groupee.nil? && current_groupee.admin?)
         @groupees = Groupee.order("created_at desc")
         respond_with @groupees
      else
         render "shared/403"
      end
   end

   #Show is the action that allows a user to see their current page. This action has replaced index 
   def show
      if @groupee.nil?
         render "shared/404"
      else
         if !current_groupee.nil?
            respond_with @groupee
         else
            render "shared/403"
         end
      end
   end

   def new
      @groupee = Groupee.new
   end

      #Create is the action that allows a new user to be added to the database.
   def create
      @groupee = Groupee.new(params[:groupee])

      if @groupee.save
         session[:groupee_id] = @groupee.id
         flash[:success] = "Welcome #{@groupee.username} to MusicBand"
         redirect_to @groupee, :notice => "Groupee Account successfully created." #Changing users to user redirects to a specific user page
      else
         render "new"
      end
   end

   #Edit is the action that allows a user to edit there current profile
   def edit

      #Prevents the current user from editing another users profile
      if current_groupee.id != @groupee.id
         redirect_to root_path, :notice => "You may only edit your own groupee information."
      end
   end

   #Update is the action that pushes a user to the database
   def update
      if (!current_groupee.nil? && current_groupee.id == @groupee.id)
         #This function updates the attributes of the current user if successfull, else renders edit
         if @groupee.update_attributes(params[:groupee])
            redirect_to @groupee, :notice => "Groupee field(s) successfully changed"
         else
            flash[:notice] = "There was an error in your submission"
            render "edit"
         end
      else
         redirect_to root_path, :notice => "You may only update your own groupee information."
      end
   end

   #Admin Only
   #Destroy is the action that removes a user from the database entirely.
   def destroy
      if (!current_groupee.nil? && current_groupee.admin?)
         groupee = Groupee.find_by_username(params[:id])
         #ensures that an admin can not delete another admin
         if !groupee.admin?
            groupee.destroy
            redirect_to groupees_path, :notice => "Groupee account was deleted"
         else
            redirect_to groupees_path
         end
      else
         render "shared/403"
      end
   end

   #Creates a definition called load_finduser which tries to find the user from the user table
   private
      def load_findgroupee
         #params[:id] remains fixed but find_by_id changes to username
         @groupee = Groupee.find_by_username(params[:id])
         #user_path(user)
      end
end
