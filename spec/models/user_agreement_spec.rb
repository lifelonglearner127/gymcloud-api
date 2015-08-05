require 'rails_helper'

RSpec.describe UserAgreement, type: :model do

  context 'associations' do
    it { is_expected.to belong_to :pro }
    it { is_expected.to belong_to :client }
    it { is_expected.to belong_to :category }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :pro_id }
    it { is_expected.to validate_presence_of :client_id }
    it { is_expected.to validate_presence_of :category_id }
    it { is_expected.to validate_presence_of :status }
  end

end
