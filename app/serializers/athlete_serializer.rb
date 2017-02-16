# frozen_string_literal: true

class AthleteSerializer < ActiveModel::Serializer
  attributes :id, :given_name, :surname, :date_of_birth
end
