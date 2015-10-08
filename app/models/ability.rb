class Ability

  include CanCan::Ability

  def initialize(user)
    @user = user
    set_aliases
    rules_defaults
    apply_roles
  end

  private

  def set_aliases
    alias_action :index, :show, to: :read
    alias_action :new, to: :create
    alias_action :edit, to: :update
    alias_action :update, :destroy, to: :modify
    alias_action :create, :read, :update, :destroy, to: :crud
  end

  def rules_defaults
    cannot :manage, :all
  end

  def apply_roles
    as_anyone
    guest? && as_guest || as_user
    client? && as_client
    pro? && as_pro
    admin? && as_admin
  end

  def as_anyone
    as_explorer_can :read, Exercise
    as_explorer_can :read, WorkoutTemplate
    as_explorer_can :read, ProgramTemplate
  end

  def as_guest
  end

  def as_user
    can :read, User
    as_self_can [:read_email, :update_email], User
    as_self_can :update, User
    can :read, UserProfile
    as_owner_can :update, UserProfile
    as_author_can :crud, Exercise
    as_author_can :crud, WorkoutTemplate
    as_author_can :crud, ProgramTemplate
    can :read, PersonalWorkout, person_id: @user.id
    can :read, WorkoutExercise do |we|
      case we.workout_type
      when 'PersonalWorkout'
        we.workout.person_id == @user.id
      end
    end
    can :read, PersonalProgram, person_id: @user.id
    can :crud, WorkoutEvent, personal_workout: {person_id: @user.id}
    can :crud, Activity do |notification|
      Activity.of_user(@user).where(id: notification.id).any?
    end
    can :crud, ExerciseResult do |exercise_result|
      exercise_result.person.id == @user.id
    end
    as_owner_can :crud, Comment
    can :read, Comment do |comment|
      case comment.commentable_type
      when 'WorkoutEventExercise'
        comment.commentable.workout_event.personal_workout.workout_template.author.id.in?(@user.pros.pluck(:id)) &&
        comment.commentable.workout_event.person.id == @user.id
      end
    end
  end

  def as_client
  end

  def as_pro
    can :crud, ClientGroup, pro_id: @user.id
    can :crud, ClientGroupMembership, client_group: {pro_id: @user.id}
    can :crud, ProgramWorkout,
      program_id: @user.program_templates.pluck(:id),
      program_type: 'ProgramTemplate',
      workout_id: @user.workout_templates.pluck(:id),
      workout_type: 'WorkoutTemplate'
    can :crud, ProgramWeek do |pw|
      case pw.program_type
      when 'ProgramTemplate'
        pw.program.author_id == @user.id
      end
    end
    can :create, PersonalWorkout,
      workout_template_id: @user.workout_templates.pluck(:id),
      person_id: @user.clients.pluck(:id)
    can [:read, :update, :disable], PersonalWorkout,
      person_id: @user.clients.pluck(:id)
    can :create, PersonalProgram,
      program_template_id: @user.program_templates.pluck(:id),
      person_id: @user.clients.pluck(:id)
    can [:read, :update, :disable], PersonalProgram,
      person_id: @user.clients.pluck(:id)
    can :create, PersonalProgram,
      program_template_id: @user.program_templates.pluck(:id),
      person_id: @user.clients.pluck(:id)
    can [:read, :update, :disable], PersonalProgram,
      person_id: @user.clients.pluck(:id)
    can :crud, WorkoutEvent,
      personal_workout: {person_id: @user.clients.pluck(:id)}
    # NOTE: Figure out with this stuff
    # if_new_can :read, WorkoutEvent
    can :crud, Folder
    can [:read, :update], PersonalProperty
    can :create, User
    can :invite, User do |user|
      user.agreements_as_client.where(pro: @user).any?
    end
    can :crud, ExerciseResult do |exercise_result|
      exercise_result.person.id.in?(@user.clients.pluck(:id))
    end
    can :read, Comment do |comment|
      case comment.commentable_type
      when 'WorkoutEventExercise'
        comment.commentable.workout_event.person.id.in?(@user.clients.pluck(:id)) &&
        comment.commentable.workout_event.personal_workout.workout_template.author.id == @user.id
      end
    end
    can :crud, WorkoutExercise do |we|
      case we.workout_type
      when 'WorkoutTemplate'
        we.workout.author_id == @user.id
      when 'PersonalWorkout'
        we.workout.person_id.in?(@user.clients.pluck(:id))
      end
    end
    can :crud, ExerciseProperty, personal_property: {person_id: @user.id}
  end

  def as_admin
    can :manage, :all
  end

  def guest?
    false
  end

  def client?
    false
  end

  def pro?
    @user.pro?
  end

  def admin?
    false
  end

  def as_self_can(action, object)
    can action, object, id: @user.id
  end

  def as_owner_can(action, object)
    can action, object, user_id: @user.id
  end

  def as_author_can(action, object)
    can action, object, author_id: @user.id
  end

  def as_explorer_can(action, object)
    can action, object, is_public: true
  end

  def if_new_can(action, object)
    can action, object do |instance|
      instance.new_record?
    end
  end

end
