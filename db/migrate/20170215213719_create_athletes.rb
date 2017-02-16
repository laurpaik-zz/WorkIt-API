# frozen_string_literal: true

class CreateAthletes < ActiveRecord::Migration[5.0]
  def change
    create_table :athletes do |t|
      t.string :given_name, null: false
      t.string :surname, null: false
      t.date :date_of_birth, null: false

      t.timestamps null: false
    end
  end
end
