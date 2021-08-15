class Book < ApplicationRecord
    has_many :comments
    belongs_to :user

    validates :title, presence: true
    validates :writer, presence: true
    validates :cost, presence: true, numericality: { only_integer: true }
    validates :limit, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
