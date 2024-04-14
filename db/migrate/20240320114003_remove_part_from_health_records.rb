# frozen_string_literal: true

class RemovePartFromHealthRecords < ActiveRecord::Migration[6.1]
  def change
    remove_column :health_records, :part, :string
  end
end
