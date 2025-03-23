class CreateKeywords < ActiveRecord::Migration[7.1]
  def change
    create_table :keywords do |t|
      t.references :diary_entry, null: false, foreign_key: true
      t.string :word

      t.timestamps
    end
  end
end
