# frozen_string_literal: true

class Athlete < ApplicationRecord
  has_many :workouts, through: :logs
  has_many :logs

  validates :given_name, presence: true
  validates :surname, presence: true
  validates :date_of_birth, presence: true
end
