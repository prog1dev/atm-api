class Api::V1::BillsController < ApplicationController
  def create
    permited_params = params.permit(bills: {}).fetch(:bills).to_h

    refill_operation = ::Bills::Refill.new.call(permited_params)

    if refill_operation.successful?
      head :ok
    else
      render json: { error: refill_operation.error }, status: :unprocessable_entity
    end
  end

  def update
    permited_params = params.permit(:total)

    withdraw_operation = ::Bills::Withdraw.new.call(permited_params.fetch(:total).to_i)

    if withdraw_operation.successful?
      head :ok
    else
      render json: { error: withdraw_operation.error }, status: :unprocessable_entity
    end
  end
end
