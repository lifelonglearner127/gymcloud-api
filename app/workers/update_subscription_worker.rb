class UpdateSubscriptionWorker

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    ::User.pros.where { !stripe_customer_id.nil? }.each do |user|
      Services::Stripe::CheckUserSubscription.!(user: user)
    end
  end

end