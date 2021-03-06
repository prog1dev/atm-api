class Bills::Refill
  attr_reader :error

  def initialize
    @error   = nil
    @success = nil
  end

  def call(bills_to_refill)
    Bill.transaction do
      bills_to_refill.each do |denomination, count|
        bills = Bill.find_by!(denomination: denomination)
        bills.lock!
        bills.count += count.to_i
        bills.save!
      end
    end

    @success = true
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
