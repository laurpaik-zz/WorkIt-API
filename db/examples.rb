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

User.transaction do
  %w(Lauren Maddie Jeff Max Alec Kate Brian Gary Anna).each do |name|
    email = "#{name}@#{name}.com"
    next if User.exists? email: email
    User.create(email: email,
                password: 'abc123',
                password_confirmation: 'abc123')
  end
end

Athlete.transaction do
  %w(Lauren Maddie Jeff Max Alec Kate Brian Gary Anna).each do |name|
    email = "#{name}@#{name}.com"
    user = User.where(email: email).first
    athlete_params = {
      user_id: user.id,
      given_name: name,
      surname: 'Tufts',
      date_of_birth: '1993-01-16'
    }
    next if Athlete.exists? athlete_params
    Athlete.create! athlete_params
  end
end

Workout.transaction do
  %w(Benchmark2k Benchmark5k Benchmark3663 Benchmark500Dash SteadyState10k
     SteadyState6k SteadyState5k SteadyState2k SteadyState3663 Anaerobic2500
     Anaerobic1221 Anaerobic1000 Sprint500 Sprint1000).each do |name|
    workout_params = {
      name: name
    }
    next if Workout.exists? workout_params
    Workout.create! workout_params
  end
end

Log.transaction do
  require 'date'
  date_time = DateTime.now

  20.times do
    log_params = {
      workout: Workout.all.sample,
      athlete: Athlete.all.sample,
      date_completed: date_time
    }

    next if Log.exists? log_params
    Log.create!(log_params)
  end
end
