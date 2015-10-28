module Services
module Payments
module StripeHandlers

class All

  def call(event)
    log(event)
  end

  private

  def log(event)
    logger.info("STRIPE: #{event.type}: #{event.id}")
  end

  def logger
    @logger ||= Rails.logger
  end

end

end
end
end
