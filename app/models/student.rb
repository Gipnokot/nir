class Student < ApplicationRecord
    self.table_name = "authors"
    has_many :nir_authors, foreign_key: "author_id"
    has_many :nirs, through: :nir_authors
  end