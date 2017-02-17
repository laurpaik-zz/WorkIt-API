# frozen_string_literal: true

class CreateLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :logs do |t|
      t.references :athlete, foreign_key: true, null: false, index: true
      t.references :workout, foreign_key: true, null: false, index: true
      t.date :date_completed, null: false

      t.timestamps
    end
  end
end
