class Attendance < ActiveRecord::Base
   belongs_to :performance
   belongs_to :groupee
   attr_accessible :groupee_id, :performance_id
   validates :groupee_id, :presence => true, :uniqueness => {:scope => :performance_id}
   validates :performance_id, :presence => true
end
