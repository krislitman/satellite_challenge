class HealthFacade
  attr_reader :message

  @@count = 0
  
  def initialize
    @message = find_message
  end
  
  def find_message
    if @@count != 6
      "Altitude is A-OK"
    else
    end
  end
  
  def self.counter(num)
    @@count += num
  end
end