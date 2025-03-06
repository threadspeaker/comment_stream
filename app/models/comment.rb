class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  after_create_commit -> {
    broadcast_prepend_to [commentable, :comments], target: "comments"
  }
  after_update_commit -> {
    broadcast_replace_to [commentable, :comments]
  }
  after_destroy_commit -> {
    broadcast_remove_to [commentable, :comments]
  }
end
