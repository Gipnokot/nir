class Cathedra < ApplicationRecord
    self.table_name = 'cathedras'
    self.primary_key = 'cathedra_id'
    belongs_to :faculty, foreign_key: 'id_fac'
    has_many :authors, foreign_key: 'cathedra_id'
    validates :name_cathedra, presence: true
    validates :id_fac, presence: true
  end