class AttendancesController < ApplicationController
   respond_to :html

   def create
      @groupee = Groupee.find_by_username(params[:groupee_id])
      @attendance = @groupee.attendances.build
      #if the performance table is not empty then allow creation of links, else do not
      #if !Performance.find(:all).empty?
      @performance = Performance.find_by_id(params[:performance][:performance_id])
      raise "Error that I am nil" unless @performance	
      @attendance.performance = @performance
      if @attendance.save
         flash[:success] = "#{@attendance.performance.name} successfully added."
      else
         flash[:failure] = "Could not add #{@attendance.performance.name}"
      end
      redirect_to @groupee
   end

   def destroy
      if (!current_groupee.nil? && current_groupee.admin?)
         #Does destroying a tagging remove it from just the bookmark_id and the tagging but not from the tag?
         @groupee = Groupee.find_by_username(params[:groupee_id])
         #Finds the tagging to destroy and removes said tag from the bookmark
         attendance = Attendance.find_by_id(params[:id])
         #removes the tagging from the bookmark
         attendance.destroy
         #Should redirect to bookmark.id upon deletion of a tagging
         redirect_to @groupee, :notice => "Attendance was deleted"
      else
         render "shared/403"
      end
   end
end
