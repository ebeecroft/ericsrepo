class CommentsController < ApplicationController
   respond_to :html
   before_filter :load_findblog

   def create
      @blog.comments.create(params[:comment])
      redirect_to @blog
   end

   def destroy
      if (!current_groupee.nil? && current_groupee.admin?)
         comment = Comment.find_by_id(params[:id])
         comment.destroy
         redirect_to @blog
      else
         render "shared/403"
      end
   end

   private
      def load_findblog
         @blog = Blog.find_by_id(params[:blog_id])
      end
end
