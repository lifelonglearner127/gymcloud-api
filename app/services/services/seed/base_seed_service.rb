module Services
module Seed

class BaseSeedService < BaseService

  run :create_records_from_fixtures

  private

  def klass
    nil
  end

  def fixtures
    []
  end

  def create_records_from_fixtures
    fixtures.map do |fixture|
      attrs = fixture.dup
      klass \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
    end
  end

end

end
end
