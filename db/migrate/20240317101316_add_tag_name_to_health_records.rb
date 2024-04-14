# frozen_string_literal: true

class AddTagNameToHealthRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :health_records, :tag_name, :string
  end
end
