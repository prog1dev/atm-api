class Api::V1::Money::WithdrawsController < ApplicationController
  def update
    withdraw_operation = Money::Withdraw.new.call(params.permit(:total).fetch(:total).to_i)

    if withdraw_operation.successful?
      head :ok
    else
      render json: { error: withdraw_operation.error }, status: :unprocessable_entity
    end
  end
end
