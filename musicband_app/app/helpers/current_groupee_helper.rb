module CurrentGroupeeHelper

   def current_groupee
      if session[:groupee_id]
         #if the Groupee table is empty then set current_groupee to nil
         if Groupee.find(:all).empty?
            @current_groupee=nil
         else
            @current_groupee ||= Groupee.find(session[:groupee_id])
         end
      else
         @current_groupee = nil
      end
   end
end
