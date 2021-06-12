class Satellite < ApplicationRecord
  validates :last_updated, presence: true
  validates :altitude, presence: true
  
  before_save :danger_counter
  
  private
  
  def danger_counter
    if self.altitude < 160
      HealthFacade.counter(1)
    end
  end
end