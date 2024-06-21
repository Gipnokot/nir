class NirAuthor < ApplicationRecord
  self.table_name = 'nir_authors'
  self.primary_key = [:nir_id, :author_id]

  belongs_to :nir, foreign_key: 'nir_id'
  belongs_to :author, foreign_key: 'author_id'

  validates :nir_id, presence: true
  validates :author_id, presence: true
  validates :percent, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :nir_id, uniqueness: { scope: :author_id }
end
