class CreateRecordTags < ActiveRecord::Migration[6.1]
  def change
    create_table :record_tags do |t|
      t.string :tag_name, null: false

      t.timestamps
    end
    
    add_index :record_tags, :tag_name, unique: true
  end
end
