class CreateDiaryEntries < ActiveRecord::Migration[7.1]
  def change
    create_table :diary_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :mood, null: false, foreign_key: true
      t.text :content
      t.string :image_url
      t.date :entry_date

      t.timestamps
    end
  end
end
