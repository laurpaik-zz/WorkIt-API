# frozen_string_literal: true

class Workout < ApplicationRecord
  validates :name, presence: true
end
