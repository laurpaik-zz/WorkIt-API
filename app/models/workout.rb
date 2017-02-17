# frozen_string_literal: true

class Workout < ApplicationRecord
  has_many :athletes, through: :logs
  has_many :logs

  validates :name, presence: true
end
