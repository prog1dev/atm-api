class Api::V1::Bills::RefillsController < ApplicationController
  def create
    permited_params = params.permit(bills: {}).fetch(:bills).to_h

    refill_operation = ::Bills::Refill.new.call(permited_params)

    if refill_operation.successful?
      head :ok
    else
      render json: { error: refill_operation.error }, status: :unprocessable_entity
    end
  end
end
