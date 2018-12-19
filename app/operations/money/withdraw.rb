class Money::Withdraw
  attr_reader :error

  def initialize
    @error   = nil
    @success = nil
  end

  def call(total)
    Money.transaction do
      available_bills = Money.pluck(:value, :count).to_h.sort_by { |k, v| -k }.to_h
      result = {}

      available_bills.each do |denomination, count|
        available_bills_count = total / denomination

        bills = available_bills_count < count ? available_bills_count : count
        result[denomination] = bills
        total -= bills * denomination
      end

      raise 'Not enough bills available' if total > 0

      result.each do |k, v|
        money = Money.find_by!(value: k)
        money.count -= v
        money.save!
      end
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
end
