class Borrow < ApplicationRecord
  belongs_to :user
  belongs_to :book

  include AASM

  aasm column: :state do
    state :borrowed, initial: true
    state :returned

    event :return_book do
      transitions from: :borrowed, to: :returned
    end

  end

end
