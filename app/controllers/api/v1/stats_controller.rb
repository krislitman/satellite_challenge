class Api::V1::StatsController < ApplicationController
  def find
    data = StatsFacade.new
    render json: StatsSerializer.new(data), status: 200
  end
end