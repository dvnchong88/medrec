# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

MedicalRecord.destroy_all
Patient.destroy_all
Doctor.destroy_all
puts "creating patients"
10.times do
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    # email: Faker::Internet.email,
    # password: '123456',
    date_of_birth: Faker::Date.between(from: '1974-09-23', to: '2003-09-25'),
    sex: Faker::Gender.type,
    weight: Faker::Number.between(from: 45, to: 145),
    height: Faker::Number.between(from: 120, to: 200),
    allergies: Faker::Food.ingredient,
    blood_type: Faker::Blood.type,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone,
    emergency_contact: Faker::Relationship.familial,
    smoker: Faker::Boolean.boolean
  )
end
puts "there are now #{Patient.count} patients."
