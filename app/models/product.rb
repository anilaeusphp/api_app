class Product < ApplicationRecord
    has_one_attached :image

    validates :name, presence: true, length: {minimum: 2, maximum: 30}
    validates :description, presence:true, length: {minimum: 2, maximum: 255}
    validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0, less_than: 1000}
    validates :price, presence: true, numericality: {greater_than: 0}

    belongs_to :category
end
