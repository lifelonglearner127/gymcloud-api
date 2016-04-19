module Services
module CRM
module Adapters

class Insightly

  def active?
    Insightly2.api_key.present?
  end

  def create_lead(attrs)
    client.create_lead(lead: attrs)
  rescue ::Insightly2::Errors::ClientError => e
    Rails.logger.error "Insightly Error: #{e.response}"
  end

  def created_user_attributes(user)
    {
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      email_address: user.email,
      lead_description: "gymcloud_user_id: #{user.id}",
      tags: [
        {TAG_NAME: 'Registered'},
        {TAG_NAME: 'Professional'}
      ]
    }
  end

  private

  def client
    ::Insightly2.client
  end

end

end
end
end
