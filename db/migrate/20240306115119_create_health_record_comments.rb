# frozen_string_literal: true

class CreateHealthRecordComments < ActiveRecord::Migration[6.1]
  def change
    create_table :health_record_comments do |t|
      t.integer :user_id, null: false
      t.integer :health_record_id, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
