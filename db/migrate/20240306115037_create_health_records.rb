# frozen_string_literal: true

class CreateHealthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :health_records do |t|
      t.integer :user_id, null: false
      # FK
      t.string :part, null: false
      # 体の部位
      t.string :exercise, null: false
      # 種目
      t.text :training_content, null: false
      # トレーニング内容
      t.text :diet_content, null: false
      # 食事内容
      t.text :today_impression, null: false
      # 本日の感想
      t.timestamps
    end
  end
end
