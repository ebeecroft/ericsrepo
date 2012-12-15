class ContactsController < ApplicationController
   respond_to :html

   #Admin only
   def index
      if (!current_groupee.nil? && current_groupee.admin?)
         @contacts = Contact.order("created_at desc")
         respond_with @contacts
      else
         render "shared/403"
      end
   end

   def new
      @contact = Contact.new
   end

   #user and admins
   def create

      @contact = Contact.new(params[:contact])

      #if ((@contact.name.empty? || @contact.email.empty?) || @contact.note.empty?)
     #    flash.now[:error] = "I have a nil value in my table"
     #    redirect_to root_path, :notice => "Nil value was detected. Sorry for the inconvenience"
     # else
         if @contact.save
            flash.now[:success] = "I was able to save directly to the database"
            redirect_to root_path, :notice => "Successfully added contact"
         else
            render "new"
         end
      #end
   end

   #Admin only
   def destroy
      if (!current_groupee.nil? && current_groupee.admin?)
         contact = Contact.find_by_id(params[:id])
         contact.destroy 
         redirect_to contacts_path, :notice => "#{contact.name} was deleted"
      else
         render "shared/403"
      end
   end
end
