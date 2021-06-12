class Satellite < ApplicationRecord
  validates :last_updated, presence: true
  validates :altitude, presence: true
end