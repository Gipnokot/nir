class Training < ApplicationRecord
    self.primary_key = 'id_training'
    validates :id_author, :name_training, :place, :training_type, :hours, :start_dt, :end_dt, :number, :date_issue, presence: true
    validates :name_training, :place, length: { maximum: 500 }
    validates :training_type, length: { maximum: 50 }
    validates :number, length: { maximum: 100 }
    validates :training_type, inclusion: { in: ['повышение квалификации', 'переподготовка', 'стажировка'] }
    validates :hours, numericality: { greater_than_or_equal_to: 0 }
  end