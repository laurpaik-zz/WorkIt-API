# frozen_string_literal: true

class CreateAthletes < ActiveRecord::Migration[5.0]
  def change
    create_table :athletes do |t|
      t.string :given_name
      t.string :surname
      t.date :date_of_birth

      t.timestamps null: false
    end
  end
end
