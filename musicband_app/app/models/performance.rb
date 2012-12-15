class Performance < ActiveRecord::Base
   has_many :attendances, :foreign_key => "performance_id", :dependent => :destroy
   attr_accessible :name

   def to_param  # overridden
      name
   end
   validates_presence_of :name, :presence => true
end
