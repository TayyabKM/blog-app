class Post < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  has_many :likes, foreign_key: 'post_id'
  has_many :comments, foreign_key: 'post_id'

  after_save :update_post_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  attribute :body, :text

  accepts_nested_attributes_for :comments

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  def update_post_counter
    user.increment!(:posts_counter)
  end
end
