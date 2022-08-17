# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = [
  'Личные вещи',
  'Транспорт',
  'Работа',
  'Для дома и дачи',
  'Недвижимость',
  'Хобби и отдых',
  'Электроника',
  'Животные'
]

unless Category.any?
  Category.create(
    categories.map do |category|
      { name: category }
    end
  )
end

7.times { User.create name: Faker::Name.name, email: Faker::Internet.email } if User.count == 1

users = User.all
categories = Category.all
bulletin_states = Bulletin.aasm.states.map(&:name)

unless Bulletin.any?
  300.times do
    bulletin = users.sample.bulletins.build(
      title: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph(sentence_count: 12),
      category: categories.sample,
      state: bulletin_states.sample.to_s
    )
    bulletin.image.attach(io: File.open("test/fixtures/files/bulletin_#{rand 1..6}.jpg"), filename: 'bulletin_image.jpg')
    bulletin.save
  end
end
