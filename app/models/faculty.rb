class Faculty < ApplicationRecord
    self.primary_key = 'id_fac'
    self.table_name = 'facultys'
    self.primary_key = 'id_fac'
    has_many :cathedras, foreign_key: 'id_fac'
    validates :name_fac, presence: true, length: { maximum: 100 }
  end