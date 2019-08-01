# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: "Charlotte",
  email: "charlotte.sacmar@gmail.com",
  password: "password"
)

50.times do |n|
  User.create!(
    name: Faker::JapaneseMedia::OnePiece.character,
    email: Faker::Internet.unique.email,
    password: "password"
  )
end

users = User.order(:created_at).take(6)

50.times do
  content = Faker::JapaneseMedia::OnePiece.quote
  users.each { |user| user.microposts.create!(content: content) }
end