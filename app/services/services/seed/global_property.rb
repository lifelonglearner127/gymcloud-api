module Services
module Seed

class GlobalProperty < BaseSeedService

  private

  def klass
    ::GlobalProperty
  end

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
