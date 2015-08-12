module Services
module Seed

class GlobalProperty < BaseService

  run do
    @result = []
    fixtures.each do |fixture|
      attrs = fixture.dup
      record = ::GlobalProperty \
        .create_with(symbol: attrs.delete(:symbol))
        .find_or_create_by(attrs)
      @result << record
    end
    @result
  end

  private

  def fixtures
    [
      {
        symbol: 'sets',
        name: 'Sets',
        unit: 'times'
      },
      {
        symbol: 'reps',
        name: 'Reps',
        unit: 'times'
      },
      {
        symbol: 'weight',
        name: 'Weight',
        unit: 'kg'
      },
      {
        symbol: 'height',
        name: 'Height',
        unit: 'cm'
      },
      {
        symbol: 'distance',
        name: 'Distance',
        unit: 'm'
      },
      {
        symbol: 'time',
        name: 'Time',
        unit: 's'
      }
    ]
  end

end

end
end
