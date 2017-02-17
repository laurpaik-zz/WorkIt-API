# frozen_string_literal: true

class AthleteSerializer < ActiveModel::Serializer
  attributes :id, :given_name, :surname, :date_of_birth, :workouts, :editable

  def editable
    scope == object.user
  end

  def workouts
    object.workouts.pluck(:id)
  end
end
