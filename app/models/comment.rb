class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary_entry
end
