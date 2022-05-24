# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
MedicalRecord.destroy_all
Patient.destroy_all
Doctor.destroy_all
puts "creating users"
users = []
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 0
  )
  users << user
end
puts "there are now #{User.count} users."

puts "creating patients"
sex = (0..2).to_a
users.each do |user|
  Patient.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.between(from: '1974-09-23', to: '2003-09-25'),
    sex: sex.sample,
    weight: Faker::Number.between(from: 45, to: 145),
    height: Faker::Number.between(from: 120, to: 200),
    allergies: Faker::Food.ingredient,
    blood_type: Faker::Blood.type,
    address: Faker::Address.full_address,
    phone_number: Faker::PhoneNumber.cell_phone,
    emergency_contact: Faker::Relationship.familial,
    smoker: Faker::Boolean.boolean,
    user: user
  )
end

puts "there are now #{Patient.count} patients."

users = []
5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 1
  )
  users << user
end
puts "there are now #{User.count} users."

puts "creating doctors"
specialty = %w[Homeopathic Endocronolgy OBGYN Cardiology Dermotology General Surgery]
users.each do |user|
  Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialty: specialty.sample,
    clinic_name: "#{Faker::FunnyName.two_word_name} Hospital",
    license_number: Faker::IDNumber.invalid,
    user: user
  )
end
puts "there are now #{Doctor.count} doctors."
