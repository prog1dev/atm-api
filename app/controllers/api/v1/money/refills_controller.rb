class Api::V1::Money::RefillsController < ApplicationController
  def create
    result = Money::Refill.new(params).call

    if result.successful?
      head :ok
    else
      render json: { error: result.error }, status: :unprocessable_entity
    end
  end
end
