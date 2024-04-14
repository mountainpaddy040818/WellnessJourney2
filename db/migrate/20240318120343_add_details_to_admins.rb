# frozen_string_literal: true

class AddDetailsToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :name, :string
  end
end
