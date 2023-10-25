class Item < ApplicationRecord
  validates :image,             presence: true
  validates :name,              presence: true
  validates :description,       presence: true
  validates :category_id,       numericality: { other_than: 1, message: "can't be blank" }
  validates :status_id,         numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :region_id,         numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_date_id,  numericality: { other_than: 1, message: "can't be blank" }
  validates :price,             presence: true,
                                numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :region
  belongs_to :shipping_date
end
