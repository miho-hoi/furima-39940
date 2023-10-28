class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :region_id, :city, :block, :building_name, :phone_number, :user_id, :item_id
  
  with_options presence: true do
    validates :user_id
    validates :item_id

    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid."}
  end

  validates :region_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, region_id: region_id, city: city, block: block, building_name: building_name, phone_number: phone_number, purchase_record_id: purchase.id)
  end
end