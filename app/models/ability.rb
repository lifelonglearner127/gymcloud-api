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
  end

  def as_guest
  end

  def as_user
    can :read, User
    can :update, User, id: @user.id
  end

  def as_client
  end

  def as_pro
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
    false
  end

  def admin?
    false
  end

  def as_owner_can(action, object)
    can action, object, user_id: @user.id
    can action, object, author_id: @user.id
  end

end
