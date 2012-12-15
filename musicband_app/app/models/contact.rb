class Contact < ActiveRecord::Base
   attr_accessible :name, :email, :note

   validates :name, :presence => true
   validates :email, :presence => true
   validates :note, :presence => true
end
