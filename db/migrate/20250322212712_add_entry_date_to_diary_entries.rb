class AddEntryDateToDiaryEntries < ActiveRecord::Migration[7.1]
  def change
    add_column :diary_entries, :entry_date, :date
  end
end
