class Money::Withdraw
  attr_reader :error

  def initialize
    @error   = nil
    @success = nil
  end

  def call(total)
    # withdraw logic

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
