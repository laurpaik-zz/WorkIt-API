# frozen_string_literal: true

class Workout < ApplicationRecord
  validates :date, presence: true
end
