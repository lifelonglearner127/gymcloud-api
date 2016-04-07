class UpdateSubscriptionWorker

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    ::User.pros.each do |user|
      Services::Stripe::CheckUserSubscription.!(user: user)
    end
  end

end