class Api::V1::Money::RefillsController < ApplicationController
  def create
    permited_params = params.permit(money: {}).fetch(:money).to_h

    refill_operation = Money::Refill.new.call(permited_params)

    if refill_operation.successful?
      head :ok
    else
      render json: { error: refill_operation.error }, status: :unprocessable_entity
    end
  end
end
