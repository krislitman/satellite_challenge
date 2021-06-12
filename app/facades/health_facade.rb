class HealthFacade
  attr_reader :message

  def initialize
    @message = find_message
  end
  
  def find_message
    if Satellite.current_average > 160.0
      "Altitude is A-OK"
    elsif Satellite.danger?
      "WARNING: RAPID ORBITAL DECAY IMMINENT"
    end
  end
end