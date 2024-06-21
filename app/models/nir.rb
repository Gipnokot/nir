class Nir < ApplicationRecord
  self.table_name = 'nirs'
  self.primary_key = 'nir_id'
  belongs_to :cathedra, optional: true
  has_many :nir_authors, foreign_key: 'nir_id'
  has_many :authors, through: :nir_authors
  validates :title, presence: true, length: { maximum: 320 }
  validates :dtr, presence: true
  validates :nirtype, presence: true, inclusion: { in: %w(article thesis monograph patent program database book) }
  validates :volume, presence: true, numericality: true
  validates :doi, presence: true, length: { maximum: 256 }
  validates :core_rinz, inclusion: { in: [0, 1] }
  validates :rinz, inclusion: { in: [0, 1] }
  validates :scopus, inclusion: { in: [0, 1] }
  validates :webofscience, inclusion: { in: [0, 1] }
  validates :vak, inclusion: { in: [0, 1] }
  validates :id_adviser, inclusion: { in: [0, 1] }
  validates :href, presence: true, length: { maximum: 600 }
  validates :output, presence: true
  accepts_nested_attributes_for :nir_authors, allow_destroy: true
  accepts_nested_attributes_for :authors
end
