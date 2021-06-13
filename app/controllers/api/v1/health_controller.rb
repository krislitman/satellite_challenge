class Api::V1::HealthController < ApplicationController
  def current
    begin
      if !Satellite.first.present?
        render json: { 'message': { 'error': 'no data to display'}}, status: 500
      else
        data = HealthFacade.new
        render json: HealthSerializer.new(data), status: 200
      end
    rescue
      render json: { 'message': { 'error': 'no data to display'}}, status: 500
    end
  end
end