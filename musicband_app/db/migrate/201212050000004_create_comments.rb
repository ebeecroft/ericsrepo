class CreateComments < ActiveRecord::Migration

   def up
      create_table :comments do |u|
         u.text :words
         u.string :author
         u.references :blog

         u.timestamps
      end
   end

   def down
      drop_table :comments
   end
end
