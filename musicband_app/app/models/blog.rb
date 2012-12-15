class Blog < ActiveRecord::Base
   belongs_to :groupee
   has_many :comments
   attr_accessible :title, :note
   validates_presence_of :title, :presence => true
   validates_presence_of :note, :presence => true
end
