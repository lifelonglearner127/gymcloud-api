require 'rails_helper'

RSpec.describe User, type: :model do

  context 'associations' do
    it { is_expected.to have_one :user_profile }
    it { is_expected.to have_many :agreements_as_pro }
    it { is_expected.to have_many :agreements_as_client }
    it { is_expected.to have_many :client_group_memberships }
    it { is_expected.to have_many :client_groups }
    it { is_expected.to have_many :client_groups_as_client }
    it { is_expected.to have_many :exercises }
    it { is_expected.to have_many :workout_templates }
    it { is_expected.to have_many :personal_workouts }
    it { is_expected.to have_many :program_templates }
    it { is_expected.to have_many :personal_programs }
    it { is_expected.to have_many :workout_events }
    it { is_expected.to have_many :personal_properties }
    it { is_expected.to have_many :exercise_results }
    it { is_expected.to have_many :folders }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :password }
  end

end
