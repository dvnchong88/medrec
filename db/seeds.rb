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

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 0
  )
end

puts "creating patients"

User.all.each do |user|
  sex = (0..2).to_a
  user.patient.update!(
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
    smoker: Faker::Boolean.boolean
  )
  # patients << user
end
puts "there are now #{User.count} users."

puts "there are now #{Patient.count} patients."

puts "creating doctors"
doctors = []
specialty = %w[Dermatology Surgery]
3.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    user_type: 1
  )
  user.doctor.update!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    specialty: specialty.sample,
    clinic_name: "#{Faker::FunnyName.two_word_name} Hospital",
    license_number: Faker::IDNumber.invalid
  )
  # doctors << user
end

puts "there are now #{Doctor.count} doctors."

puts "creating medical records"

Patient.all.each do |user|
  rand(5...10).times do
    MedicalRecord.create!(
      symptoms: "Asthma",
      diagnosis: "I was diagnosed with high blood pressure today",
      date: Faker::Date.between(from: '1974-09-23', to: '2003-09-25'),
      patient: user,
      doctor: Doctor.all.sample
    )
  end
end

User.all.each do |user|
  user.qr_code = "http://localhost:3000/patients/#{user.patient.id}/medical_records" if user.user_type == "patient"
  user.save
end
puts "there are now #{MedicalRecord.count} medical records."
