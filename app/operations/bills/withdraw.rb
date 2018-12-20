class Bills::Withdraw
  attr_reader :error, :result

  def initialize
    @error   = nil
    @success = nil
    @result  = nil
  end

  def call(total)
    Bill.transaction do
      bills_to_withdraw = calc_bills_to_withdraw(total)

      withdraw_from_db(bills_to_withdraw)

      @result = format_result(bills_to_withdraw)
    end

    @success = true
  rescue PG::CheckViolation => e
    @success = false
    @error   = 'Not enough bills available'
  rescue StandardError => e
    @success = false
    @error   = e.message
  ensure
    return self
  end

  def successful?
    @success
  end

  private

  def calc_bills_to_withdraw(total_to_withdraw)
    available_bills = Bill.pluck(:denomination, :count).to_h.sort_by { |k, v| -k }.to_h
    result = {}

    available_bills.each do |denomination, count|
      available_bills_count = total_to_withdraw / denomination

      bills = available_bills_count < count ? available_bills_count : count
      result[denomination] = bills
      total_to_withdraw -= bills * denomination
    end

    raise NotEnoughBillsAvailable.new('Not enough bills available') if total_to_withdraw > 0

    result
  end

  def withdraw_from_db(bills_to_withdraw)
    bills_to_withdraw.each do |denomination, count|
      bills = Bill.find_by!(denomination: denomination)
      bills.count -= count
      bills.save!
    end
  end

  def format_result(bills_to_withdraw)
    bills_to_withdraw.reject { |_, count| count.zero? }
  end

  class NotEnoughBillsAvailable < StandardError; end
end
