# frozen_string_literal: true

class Athlete < ApplicationRecord
  has_many :workouts, through: :logs
  has_many :logs
  belongs_to :user

end
