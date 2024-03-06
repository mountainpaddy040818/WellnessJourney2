class CreateHealthRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :health_records do |t|
      t.integer :user_id
      # FK
      t.string :part, null: false, default: ""
      # 体の部位
      t.string :exercise, null: false, default: ""
      # 種目
      t.text :training_content, null: false, default: ""
      # トレーニング内容
      t.text :diet_content, null: false, default: ""
      # 食事内容
      t.text :today_impression, null: false, default: ""
      # 本日の感想
      t.timestamps
    end
  end
end
