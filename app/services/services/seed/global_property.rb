module Services
module Seed

class GlobalProperty < BaseSeedService

  KLASS = ::GlobalProperty

  FIXTURES =
    [
      {
        symbol: 'sets',
        name: 'Sets',
        unit: 'times',
        position: 0
      },
      {
        symbol: 'reps',
        name: 'Reps',
        unit: 'times',
        position: 1
      },
      {
        symbol: 'weight',
        name: 'Weight',
        unit: 'kg',
        position: 2
      },
      {
        symbol: 'height',
        name: 'Height',
        unit: 'cm',
        position: 3
      },
      {
        symbol: 'distance',
        name: 'Distance',
        unit: 'm',
        position: 4
      },
      {
        symbol: 'time',
        name: 'Time',
        unit: 's',
        position: 5
      }
    ]

end

end
end
