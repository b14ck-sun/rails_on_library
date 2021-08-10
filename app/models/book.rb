class Book < ApplicationRecord
    has_many :comments

    validates :title, presence: true
    validates :writer, presence: true
    validates :cost, presence: true, numericality: { only_integer: true }
    validates :limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :creator, presence: true
end
