# frozen_string_literal: true

class AddUserIdToAthletes < ActiveRecord::Migration[5.0]
  def change
    add_reference :athletes, :user, index: true, foreign_key: true, null: false
  end
end
