Category.destroy_all
Review.destroy_all
User.destroy_all
Product.destroy_all
Tag.destroy_all

Category.create([
  {name: 'Science'},
  {name: 'Music'},
  {name: 'Arts'},
  {name: 'Memes'},
  {name: 'Literature'},
  {name: 'Programming'}
])

50.times do
  Product.create title: Faker::Hacker.say_something_smart,
                 description: Faker::Hipster.paragraph,
                 price: Faker::Commerce.price
end

50.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
  )
end

products = Product.all

products.each do |p|
  rand(1..5).times do
    Review.create(
      product_id: p.id,                  #!!! OTHERWISE IT WON'T WORK!
      body: Faker::Company.buzzword,
      rating: rand(5))
    end
  end

10.times do
  Tag.create name: Faker::Hipster.word
end
#
#   puts Cowsay.say "50 users created", :cow
  # puts Cowsay.say "Created #{Review.all.count} reviews!", :ghostbusters
