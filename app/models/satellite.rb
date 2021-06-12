class Satellite < ApplicationRecord
  validates :last_updated, presence: true
  validates :altitude, presence: true
  
  scope :current_average, -> { all.average(:altitude).to_f }
end