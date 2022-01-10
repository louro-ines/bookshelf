class Author < ApplicationRecord
  validates :first_name, :last_name, :age, presence: true

  has_many :books, dependent: :destroy
end
