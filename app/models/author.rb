class Author < ApplicationRecord
  self.table_name = 'authors'
  self.primary_key = 'author_id'
  belongs_to :cathedra, foreign_key: 'cathedra_id'
  has_many :nir_authors, foreign_key: 'author_id'
  has_many :nirs, through: :nir_authors, foreign_key: 'author_id'
  validates :lastname, :name, :fathername, :status, presence: true
  validates :cathedra_id, presence: true
  def full_name
    "#{lastname} #{name} #{fathername}"
  end
  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ['Last Name', 'First Name', 'Father Name', 'Cathedra', 'Status']
      all.each do |author|
        csv << [author.lastname, author.name, author.fathername, author.cathedra.name_cathedra, author.status]
      end
    end
  end
end
