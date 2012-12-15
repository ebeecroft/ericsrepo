class CreateAttendances < ActiveRecord::Migration

   def up
      create_table :attendances do |u|
         u.references :groupee
         u.references :performance

         u.timestamps
      end
   end

   def down
      drop_table :attendances
   end
end
