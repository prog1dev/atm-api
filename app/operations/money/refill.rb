class Money::Refill
  attr_reader :error

  def initialize
    @error   = nil
    @success = nil
  end

  def call(params)
    Money.transaction do
      @params.each do |par_value, count|
        money = Money.find_by!(value: par_value)
        money.lock!
        money.count += count
        money.save!
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
