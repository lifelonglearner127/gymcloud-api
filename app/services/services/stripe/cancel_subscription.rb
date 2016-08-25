module Services
module Stripe

class CancelSubscription < BaseService

  def run
    delete
  end

  def input_params
    [:user, :id]
  end

  private

  def delete
    subscription = ::Stripe::Subscription.retrieve(@id)

    raise 'wrong customer' if subscription.customer != @user.stripe_customer_id

    subscription.delete
    @user.update_attribute(:subscription_end_at, DateTime.now)

    subscription
  end

end

end
end
