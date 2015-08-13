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
  end

  def as_guest
  end

  def as_user
    can :read, User
    as_self_can :update, User
    can :read, UserProfile
    as_owner_can :update, UserProfile
    as_author_can :crud, Exercise
    as_author_can :crud, WorkoutTemplate
    can :read, PersonalWorkout, person_id: @user.id
    can :read, PersonalProgram, person_id: @user.id
  end

  def as_client
  end

  def as_pro
    can :crud, ClientGroup, pro_id: @user.id
    can :crud, ClientGroupMembership, client_group: {pro_id: @user.id}
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

end
