# frozen_string_literal: true

class LogSerializer < ActiveModel::Serializer
  attributes :id, :date_completed

  has_one :workout
  has_one :athlete

  def athletes
    object.athletes.pluck(:id)
  end
end
