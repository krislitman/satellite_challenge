class Api::V1::HealthController < ApplicationController
  def current
    data = HealthFacade.new
    require 'pry'; binding.pry
    render json: { 'message': { 'error': 'no data to display'}}, status: 500
  end
end