class SongsController < ApplicationController
   respond_to :html

   def index
   end

   def show
      render "shared/404"
   end
end
