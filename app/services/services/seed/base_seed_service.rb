module Services
module Seed

class BaseSeedService < BaseService

  KLASS = nil
  FIXTURES = []

  run :create_records_from_fixtures

  private

  def create_records_from_fixtures
    FIXTURES.map do |fixture|
      attrs = fixture.dup
      KLASS \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
    end
  end

end

end
end
