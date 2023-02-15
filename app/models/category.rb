class Category < ApplicationRecord
  include PgSearch::Model

  TITLE_MIN_LENGTH = 3
  TITLE_MAX_LENGTH = 40

  searchkick word_start: %i[title], searchable: [:title]

  has_many :products, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, uniqueness: true, length: { minimum: TITLE_MIN_LENGTH, maximum: TITLE_MAX_LENGTH }

  multisearchable against: %i[title]

  def search_data
    {
      type: self.class,
      title:
    }
  end
end
