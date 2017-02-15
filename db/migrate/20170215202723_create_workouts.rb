# frozen_string_literal: true

class CreateWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :workouts do |t|
      t.date :date, null: false

      t.timestamps
    end
  end
end
