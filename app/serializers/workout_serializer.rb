# frozen_string_literal: true

class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :name, :athletes

  def athletes
    object.athletes.pluck(:id)
  end
end
