class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.bigint :content_id
      t.string :content_type
      t.decimal :price
      t.integer :quality
      t.boolean :expired, default: false
      t.datetime :available_until

      t.timestamps
    end

    add_index :purchases, %i[user_id content_type content_id], unique: true
    add_index :purchases, %i[user_id expired]
  end
end
