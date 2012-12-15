class BlogsController < ApplicationController
   respond_to :html
   before_filter :load_findblog, :only => [:show, :edit, :update]

   def index
      @blogs = Blog.order("created_at desc")
      respond_with @blogs
   end

   def show
      if @blog.nil?
         render "shared/404"
      else
         respond_with @blog
      end
   end

   def new
      @blog = Blog.new
   end

   def create
      @blog = Blog.new(params[:blog])
      @blog.groupee_id = current_groupee.id

      if @blog.save
         flash[:success] = "Blog #{@blog.title} successfully created."
         redirect_to @blog
      else
         render "new"
      end
   end

   def edit
      #Prevents the current user from editing another users profile
      if current_groupee.id != @blog.groupee_id
         redirect_to root_path, :notice => "You may only edit your own blogs."
      end
   end

   def update
      if (!current_groupee.nil? && current_groupee.id == @blog.groupee_id)
         if @blog.update_attributes(params[:blog])
            flash[:success] = "Blog successfully updated."
            redirect_to blog_path
         else
            render "edit"
         end
      else
         redirect_to root_path, :notice => "You may only update your own blogs."
      end
   end

   def destroy
      if(!current_groupee.nil? && current_groupee.admin?)
         blog = Blog.find_by_id(params[:id])
         blog.destroy 
         redirect_to blogs_path, :notice => "#{blog.title} was deleted"
      else
         render "shared/403"
      end
   end

   private
      #finds the current blog and stores it in the @blog variable
      def load_findblog
         @blog = Blog.find_by_id(params[:id])
      end
end
