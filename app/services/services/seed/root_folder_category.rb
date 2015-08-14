module Services
module Seed

class RootFolderCategory < BaseSeedService

  private

  def klass
    ::RootFolderCategory
  end

  def fixtures
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
end
