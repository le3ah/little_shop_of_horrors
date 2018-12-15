class Order < ApplicationRecord
  validate_presence_of :status

  belongs_to :user
end
