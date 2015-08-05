require 'rails_helper'

RSpec.describe GlobalProperty, type: :model do

  context 'associations' do
    it { is_expected.to have_many :personal_properties }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :symbol }
    it { is_expected.to validate_uniqueness_of :symbol }
  end

end
