class CreatePerformances < ActiveRecord::Migration

   def up
      create_table :performances do |u|
         u.string :name

         u.timestamps
      end
   end

   def down
      drop_table :performances
   end
end
