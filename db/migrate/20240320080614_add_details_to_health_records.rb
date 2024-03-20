class AddDetailsToHealthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :health_records, :genre_id, :integer
    add_column :health_records, :name, :string
  end
end
