class StatsFacade
  attr_reader :minimum,
              :maximum,
              :average
  def initialize
    @minimum = find_minimum
    @maximum = find_maximum
    @average = find_average
  end
end