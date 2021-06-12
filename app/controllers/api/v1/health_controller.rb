class Api::V1::HealthController < ApplicationController
  def current
    render json: { 'message': { 'error': 'no data to display'}}, status: 500
  end
end