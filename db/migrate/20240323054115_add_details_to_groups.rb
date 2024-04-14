# frozen_string_literal: true

class AddDetailsToGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :user_id, :integer
  end
end
