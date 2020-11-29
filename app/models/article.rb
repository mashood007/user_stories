class Article < ApplicationRecord
  enum status: %i[draft published archived]
  has_many :article_categories
  has_many :categories, through: :article_categories
  belongs_to :user
  accepts_nested_attributes_for :article_categories

  scope :by_users, -> (user_id) { where(user_id: user_id) unless user_id.blank? } 
  scope :by_keywords, -> (query) {where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%") unless query.blank?}
  scope :categories, -> (cat_array) {left_outer_joins(:article_categories).where("article_categories.category_id IN(?)", cat_array) unless cat_array.blank? }

  class << self
    def search(params)
       self.all.by_users(params[:users]).by_keywords(params[:text]).categories(params[:category_ids])
    end
  end
end
