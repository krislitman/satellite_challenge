class Api::V1::StatsController < ApplicationController
  def find
    data = StatsFacade.new
    
    # render json: StatsSerializer(data), status: 201
  end
end