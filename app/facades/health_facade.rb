class HealthFacade
  attr_reader :message

  def initialize
    @message = find_message
  end
  
  def find_message
    Altitude.first.status
  end
end