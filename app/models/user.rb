class User < ApplicationRecord
    has_many :posts, foreign_key: 'author_id'
    has_many :comments, foreign_key: 'author_id'
    has_many :likes, foreign_key: 'user_id'
    validates :name, presence: true
    validates :photo, presence: true
    validates :posts_counter,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                message: 'must be an integer greater than or equal to zero'
              },
              on: :create

    def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
