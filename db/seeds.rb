# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Creating Seeds'

puts '..Deleting Authors'
Author.destroy_all

puts '..Creating 2 Authors'
author = Author.create(
  first_name: 'Andreas',
  last_name: 'Antonopoulos',
  age: 50
)

author2 = Author.create(
  first_name: 'Daniel',
  last_name: 'Kahneman',
  age: 87
)

puts '..Deleting Books'
Book.destroy_all

puts '..Creating 3 Books'
Book.create(
  author: author,
  title: 'Mastering Bitcoin'
)

Book.create(
  author: author,
  title: 'Mastering the Lightning Network'
)

Book.create(
  author: author2,
  title: 'Thinking Fast and Slow'
)

puts 'Done 🌱'
