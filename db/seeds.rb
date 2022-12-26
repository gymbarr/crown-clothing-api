# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.find_or_create_by(email: 'g-barr@mail.ru') do |user|
  user.username = 'Andrey'
  user.password = 'password'
end

unless first_user.has_role?(Role.admin_user_role)
  first_user.add_role(Role.admin_user_role)
  first_user.remove_role(Role.basic_user_role)
end

User.find_or_create_by(email: 'andryuh2a@mail.ru') do |user|
  user.username = 'Andryuh2a'
  user.password = 'password'
end

10.times do
  FactoryBot.create(:user)
end
