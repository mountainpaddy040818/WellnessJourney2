# frozen_string_literal: true

class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :followed_id, null: false
      # フォローした時のid
      t.integer :follower_id, null: false
      # フォローされた時のid
      t.timestamps
    end
  end
end
