class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :followed_id
      # フォローした時のid
      t.integer :follower_id
      # フォローされた時のid
      t.timestamps
    end
  end
end
