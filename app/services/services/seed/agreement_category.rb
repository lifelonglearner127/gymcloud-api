module Services
module Seed

class AgreementCategory < BaseSeedService

  private

  def klass
    ::AgreementCategory
  end

  def fixtures
    [
      {
        symbol: 'me',
        title: 'Self Training',
        pro_title: 'Me',
        client_title: 'Me'
      },
      {
        symbol: 'trainer',
        title: 'Trainer - Client',
        pro_title: 'Trainer',
        client_title: 'Client'
      },
      {
        symbol: 'coach',
        title: 'Coach - Athlete',
        pro_title: 'Coach',
        client_title: 'Athlete'
      }
    ]
  end
end

end
end
