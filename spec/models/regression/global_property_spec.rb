require 'rails_helper'

RSpec.describe GlobalProperty do

  # === Relations ===
  
  
  it { is_expected.to have_many :personal_properties}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :symbol }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :unit }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["symbol"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :unit }
	it { is_expected.to validate_presence_of :symbol }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end