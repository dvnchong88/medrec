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
User.destroy_all

puts "creating users"

patients = []
5.times do
  sex = (0..2).to_a
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 0
  )
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
  patients << user
end
puts "there are now #{User.count} users."

puts "creating patients"
puts "there are now #{Patient.count} patients."

doctors = []
specialty = %w[Homeopathic Endocronolgy OBGYN Cardiology Dermotology General Surgery]
2.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 1
  )
  Doctor.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialty: specialty.sample,
    clinic_name: "#{Faker::FunnyName.two_word_name} Hospital",
    license_number: Faker::IDNumber.invalid,
    user: user
  )
  doctors << user
end

puts "creating doctors"
puts "there are now #{Doctor.count} doctors."

puts "creating medical records"

patients.each do |user|
  rand(5...10).times do
    MedicalRecord.create!(
      symptoms: "Asthma",
      diagnosis: "I was diagnosed with high blood pressure today",
      date: Faker::Date.between(from: '1974-09-23', to: '2003-09-25'),
      patient: user.patient,
      doctor: doctors.sample.doctor
    )
  end
end
puts "there are now #{Doctor.count} medical records."
