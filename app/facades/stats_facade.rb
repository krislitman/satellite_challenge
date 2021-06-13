class StatsFacade
  attr_reader :minimum,
              :maximum,
              :average
  def initialize
    @minimum = find_minimum
    @maximum = find_maximum
    @average = find_average
  end
  
  def find_minimum
    found = Satellite.within_five_minutes
    .order(:altitude)
    .limit(1)
    .pluck(:altitude)
    found[0]
  end
  
  def find_maximum
    found = Satellite.within_five_minutes
    .order(altitude: :desc)
    .limit(1)
    .pluck(:altitude)
    found[0]
  end
  
  def find_average
    avg = Satellite.within_five_minutes
    .average(:altitude)
    
    avg.to_f
  end
end