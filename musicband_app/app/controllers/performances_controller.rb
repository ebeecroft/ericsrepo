class PerformancesController < ApplicationController
   respond_to :html

   def index
      @performances = Performance.order("created_at desc")
      respond_with @performances
   end

   def show
      @performance = Performance.find_by_name(params[:id])

      if @performance.nil?
         render "shared/404"
      else
         respond_with @peformance
      end
   end

   def new
      if (!current_groupee.nil? && current_groupee.admin?)
         @performance = Performance.new
      else
         render "shared/403"
      end
   end

   def create
      if (!current_groupee.nil? && current_groupee.admin?)
         @performance = Performance.new(params[:performance])

         if @performance.save
            flash[:success] = "Performance #{@performance.name} successfully created"
            redirect_to performances_path
         else
            render "new"
         end
      else
         render "shared/403"
      end
   end
end
