require 'rails_helper'

RSpec.describe AgreementCategory, type: :model do

  context 'associations' do
    it { is_expected.to have_many :user_agreements }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :pro_title }
    it { is_expected.to validate_presence_of :client_title }
  end

end
