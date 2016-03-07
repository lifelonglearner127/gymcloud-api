class LoggedStripeEvent < ActiveRecord::Base

  serialize :data, Hash

end
