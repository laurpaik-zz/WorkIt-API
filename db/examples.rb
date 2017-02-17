# frozen_string_literal: true
# This file should contain all the record creation needed to experiment with
# your app during development.
#
# The data can then be loaded with the rake db:examples (or created alongside
# the db with db:nuke_pave).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# %w(antony jeff matt jason).each do |name|
#   email = "#{name}@#{name}.com"
#   next if User.exists? email: email
#   User.create!(email: email,
#                password: 'abc123',
#                password_confirmation: nil)
# end
# Athlete.transaction do
#   %w(lauren maddie jeff max alec kate brian gary anna).each do |name|
#     athlete_params = {
#       given_name: name,
#       family_name: 'Tufts'
#     }
#     next if Athlete.exists? athlete_params
#     Athlete.create! athlete_params
#   end
# end
#
# Workout.transaction do
#   %w(2017-01-08 2017-01-013 2017-01-18 2017-01-20 2017-01-24).each do |date|
#     workout_params = {
#       date: date
#     }
#     next if Workout.exists? workout_params
#     Workout.create! workout_params
#   end
# end
