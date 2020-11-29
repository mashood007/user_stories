class Article < ApplicationRecord
  enum status: %i[draft published archived]
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user
  accepts_nested_attributes_for :article_categories
end
