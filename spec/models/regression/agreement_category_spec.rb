require 'rails_helper'

RSpec.describe AgreementCategory do

  # === Relations ===
  
  
  it { is_expected.to have_many :user_agreements}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :title }
	it { is_expected.to have_db_column :pro_title }
	it { is_expected.to have_db_column :client_title }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :title }
	it { is_expected.to validate_presence_of :pro_title }
	it { is_expected.to validate_presence_of :client_title }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end