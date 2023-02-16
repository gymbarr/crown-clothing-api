class Product < ApplicationRecord
  include PgSearch::Model
  include Rails.application.routes.url_helpers

  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  searchkick word_start: %i[title], searchable: [:title]

  belongs_to :category
  has_many :variants, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { minimum: TITLE_MIN_LENGTH, maximum: TITLE_MAX_LENGTH }

  multisearchable against: %i[title]

  def search_data
    {
      type: self.class,
      title:,
      price:,
      imageUrl: url_for(self.image)
    }
  end
end
