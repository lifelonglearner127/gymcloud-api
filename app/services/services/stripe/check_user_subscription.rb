module Services
module Stripe

class CheckUserSubscription < BaseService

  def run
    check
  end

  def input_params
    [:user, :customer]
  end

  private

  def check
    subscriptions = customer.subscriptions.all
    subscription = subscriptions.data.detect do |sub|
      %w(trialing active).include?(sub.status)
    end
    return subscription if subscription.nil?
    update_user(subscription)
    subscription
  end

  def customer
    @customer ||= ::Stripe::Customer.retrieve(@user.stripe_customer_id)
  end

  def update_user(sub)
    is_trialing = sub.status == 'trialing'
    end_date = (is_trialing && sub.trial_end) || sub.current_period_end
    @user.update_attributes!(
      is_trialing: is_trialing,
      subscription_end: Time.at(end_date).utc.to_datetime
    )
  end

end

end
end
