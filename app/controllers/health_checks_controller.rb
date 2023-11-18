class HealthChecksController < ApplicationController
  def show
    render json: {}, status: 200
  end
end
