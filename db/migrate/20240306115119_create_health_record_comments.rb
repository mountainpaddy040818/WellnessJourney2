# frozen_string_literal: true

class CreateHealthRecordComments < ActiveRecord::Migration[6.1]
  def change
    create_table :health_record_comments do |t|
      t.integer :user_id
      t.integer :health_record_id
      t.text :comment, null: false
      # コメント
      t.timestamps
    end
  end
end
