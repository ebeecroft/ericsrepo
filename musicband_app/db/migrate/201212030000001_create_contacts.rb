class CreateContacts < ActiveRecord::Migration

   def up
      create_table :contacts do |u|
         u.string :name
         u.string :email
         u.text :note

         u.timestamps
      end
   end

   def down
      drop_table :contacts
   end
end
