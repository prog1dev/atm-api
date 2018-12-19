class WithdrawsController < ApplicationController
  def update
    withdraw_operation = Money::Withdraw.new.call(params.fetch(:total))

    if withdraw_operation.successful?
      head :ok
    else
      render json: { error: withdraw_operation.error }, status: :unprocessable_entity
    end
  end
end
