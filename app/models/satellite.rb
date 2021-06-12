class Satellite < ApplicationRecord
  validates :last_updated, presence: true
  validates :altitude, presence: true
  
  scope :current_average, -> { all.average(:altitude).to_f }

  @@danger_counter = 0
  @@resumed = 0
  
  before_save :danger_check
  
  def self.danger?
    return true if @@danger_counter >= 6
    false
  end
  
  def self.resume_count
    @@resumed
  end
  
  private
  
  def danger_check
    if Satellite.current_average < 160 && Satellite.danger? == false && @@resumed == 0
      @@danger_counter += 1
    elsif Satellite.current_average > 160 && Satellite.danger? == true && @@resumed == 0
      @@resumed = 6
      @@danger_counter = 0
    elsif @@resumed > 0
      @@resumed -= 1
      @@danger_counter = 0
    else
      @@danger_counter = 0
    end
  end
end