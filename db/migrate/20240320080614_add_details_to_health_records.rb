# frozen_string_literal: true

class AddDetailsToHealthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :health_records, :genre_id, :integer, null: false
    add_column :health_records, :name, :string, null: false
  end
end
