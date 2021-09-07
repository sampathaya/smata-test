class Category < ApplicationRecord
  include ActiveModel::Validations
  validates_with NameValidator
  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :vertical
  has_many :courses
end
