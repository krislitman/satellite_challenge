class Api::V1::StatsController < ApplicationController
  def find
    begin
      if !Satellite.first.present?
        render json: { 'message': { 'error': 'no data to display'}}, status: 500
      else
        data = StatsFacade.new
        render json: StatsSerializer.new(data), status: 200
      end
    rescue
      render json: { 'message': { 'error': 'no data to display'}}, status: 500
    end
  end
end