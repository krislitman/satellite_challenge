class Altitude < ApplicationRecord
  validates :status, presence: true
  
  def check_status(current_status)
    self.status = current_status
    self.save
  end
end