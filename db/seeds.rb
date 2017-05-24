# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 10.times do |n|
#   Product.create(
#     title: Faker::Hipster.sentence(3),
#     description: Faker::Hipster.sentence(5),
#     price: Faker::Commerce.price
#   )
#   puts "Product Created #{n}"
# end

10.times do |n|
  User.create(
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email
  )
puts Cowsay.say "User created #{n}", :cow   # OR: puts "Product Created #{n}"
end
