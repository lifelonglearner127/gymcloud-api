module Services
module GroupAssignment

class Workout < BaseService

  def run
    create_personal
  end

  def input_params
    [:template, :group, :pro, :create_activities]
  end

  def defaults
    {create_activities: false}
  end

  def build_personal
    service = Services::PersonalAssignment::Workout.new(
      template: @template,
      user: @group.clients.first
    )
    service.build_personal
  end

  private

  def template_duplicate
    template = Services::TemplateDuplicating::Workout.!(
      workout: @template,
      user: @template.user,
      is_visible: false
    )
    template.client_group = @group
    template.save!
    template
  end

  def create_personal
    ids = assigned_client_ids
    users = @group.clients.where { id << ids }
    users.map do |user|
      workout = Services::PersonalAssignment::Workout.!(
        template: template_duplicate,
        user: user
      )
      create_activity_for(workout) if @create_activities
      workout
    end
  end

  def assigned_client_ids
    ::PersonalWorkout
      .assigned_by(@pro)
      .where(workout_template: @template)
      .pluck(:person_id)
      .to_a
  end

  def create_activity_for(workout)
    workout.create_activity(
      action: :create,
      owner: @pro,
      recipient: workout.person
    )
  end

end

end
end
