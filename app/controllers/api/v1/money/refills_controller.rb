class Api::V1::Money::RefillsController < ApplicationController
  def create
    refill_operation = Money::Refill.new.call(params)

    if refill_operation.successful?
      head :ok
    else
      render json: { error: refill_operation.error }, status: :unprocessable_entity
    end
  end
end
