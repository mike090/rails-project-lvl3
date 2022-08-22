# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times { Category.create name: Faker::Restaurant.type } if Category.count < 10

7.times { User.create name: Faker::Name.name, email: Faker::Internet.email } if User.count < 7

users = User.all
categories = Category.all
bulletin_states = Bulletin.aasm.states.map(&:name)

if Bulletin.count < 300
  300.times do
    bulletin = users.sample.bulletins.build(
      title: Faker::Restaurant.name,
      description: Faker::Restaurant.description,
      category: categories.sample,
      state: bulletin_states.sample.to_s
    )
    bulletin.image.attach(io: File.open("test/fixtures/files/bulletin_#{rand 1..6}.jpg"), filename: 'bulletin_image.jpg')
    bulletin.save
  end
end
