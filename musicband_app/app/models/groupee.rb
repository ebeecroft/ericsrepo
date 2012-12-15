class Groupee < ActiveRecord::Base
   has_many :attendances, :foreign_key => "groupee_id", :dependent => :destroy
   has_many :blogs
   has_many :comments
   attr_accessible :first_name, :last_name, :username, :email, :password, :password_confirmation
   has_secure_password

   def to_param  # overridden
      username
   end
   validates :first_name, :presence => true
   validates :last_name, :presence => true
   validates :email, :presence => true
   validates :username, :presence => true, :uniqueness =>{:case_sensitive => false}
   validates :password, :length => {:minimum => 6}
   validates :password_confirmation, :presence => true
end
