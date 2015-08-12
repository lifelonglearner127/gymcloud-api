module Services
module Seed

class AgreementCategory < BaseService

  run do
    @result = []
    fixtures.each do |fixture|
      attrs = fixture.dup
      record = ::AgreementCategory \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
      @result << record
    end
  end

  private

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
