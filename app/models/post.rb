class Post < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  scope :search, ->(query) {
    if query.present?
      where('LOWER(title) LIKE :query OR LOWER(body) LIKE :query', query: "%#{query.downcase}%")
    end
  }
end

