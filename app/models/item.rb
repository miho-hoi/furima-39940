class Item < ApplicationRecord
  validates :name,              presence: true
  validates :description,       presence: true
  validates :category_id,       presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :status_id,         presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :postage_id,        presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :region_id,         presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :shipping_date_id,  presence: true, numericality: { other_than: 1 ,message: "can't be blank"} 
  validates :price,             presence: true, numericality: { only_integer: true, greater_than: 300, less_than: 10000000 ,message: ""}

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :region
  belongs_to :shipping_date
end
