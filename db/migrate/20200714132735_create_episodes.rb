class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.string :title
      t.text :plot
      t.integer :number
      t.belongs_to :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
