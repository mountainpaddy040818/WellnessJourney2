# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
GUEST_USER_EMAIL = "admin@example.com"

Admin.find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
  user.name = "AdminUser"
  user.password = "admin123"
end