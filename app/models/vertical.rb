class Vertical < ApplicationRecord
  include ActiveModel::Validations
  validates_with NameValidator
  validates :name, presence: true, length: { minimum: 3 }
  has_many :categories
  belongs_to :user

  after_commit :reindex_product

  searchkick

  def reindex_product
    Vertical.reindex
  end
end
