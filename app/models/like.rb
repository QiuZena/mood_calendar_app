class Like < ApplicationRecord
  belongs_to :user
  belongs_to :diary_entry
end
