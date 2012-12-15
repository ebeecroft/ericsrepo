class Comment < ActiveRecord::Base
   belongs_to :blog
   attr_accessible :words, :author
   validates :words, :presence => true
   validates :author, :presence => true
end
