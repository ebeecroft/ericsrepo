namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = Groupee.create!(first_name: "Monty", last_name: "Mole",
                 email: "mole@many.com", username: "mmole",
                 password: "mmole1",
                 password_confirmation: "mmole1")
    admin.toggle!(:admin)
  end
end
