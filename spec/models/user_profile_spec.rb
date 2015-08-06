require 'rails_helper'

RSpec.describe UserProfile, type: :model do

  context 'associations' do
    it { is_expected.to belong_to :user }
  end

  context 'validations' do
  end

end
