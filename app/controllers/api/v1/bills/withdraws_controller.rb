class Api::V1::Bills::WithdrawsController < ApplicationController
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