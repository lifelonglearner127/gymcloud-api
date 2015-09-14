require 'rails_helper'

RSpec.describe ProgramWeek do

  # === Relations ===
  it { is_expected.to belong_to :program}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :program_id }
	it { is_expected.to have_db_column :program_type }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["program_type", "program_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end