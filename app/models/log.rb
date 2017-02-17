# frozen_string_literal: true

class Log < ApplicationRecord
  belongs_to :athlete
  belongs_to :workout
  validates :athlete, presence: true
  validates :workout, presence: true
  validates :date_completed, presence: true
end
