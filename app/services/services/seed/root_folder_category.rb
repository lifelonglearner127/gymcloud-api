module Services
module Seed

class RootFolderCategory < BaseSeedService

  KLASS = ::RootFolderCategory

  FIXTURES =
    [
      {
        klass: 'Exercise',
        name: 'Exercises'
      },
      {
        klass: 'WorkoutTemplate',
        name: 'Workouts'
      },
      {
        klass: 'ProgramTemplate',
        name: 'Programs'
      }
    ]

end

end
end
