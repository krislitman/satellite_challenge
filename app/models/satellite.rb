class Satellite < ApplicationRecord
  validates :last_updated, presence: true
  validates :altitude, presence: true
  
  scope :current_average, -> { all.average(:altitude).to_f }
  scope :within_five_minutes, -> { where("last_updated <= ? AND last_updated > ?", Time.now, 5.minutes.ago) }
end