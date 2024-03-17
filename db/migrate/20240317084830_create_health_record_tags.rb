class CreateHealthRecordTags < ActiveRecord::Migration[6.1]
  def change
    create_table :health_record_tags do |t|
      t.references :health_record, null: false, foreign_key: true
      t.references :record_tag, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :health_record_tags, [:health_record_id,:record_tag_id], unique: true
  end
end
