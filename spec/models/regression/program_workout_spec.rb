require 'rails_helper'

RSpec.describe ProgramWorkout do

  # === Relations ===
  it { is_expected.to belong_to :workout}
	it { is_expected.to belong_to :program}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :workout_id }
	it { is_expected.to have_db_column :workout_type }
	it { is_expected.to have_db_column :program_id }
	it { is_expected.to have_db_column :program_type }
	it { is_expected.to have_db_column :workout_version }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["program_type", "program_id"]}
	it { is_expected.to have_db_index ["workout_type", "workout_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :workout_id }
	it { is_expected.to validate_presence_of :program_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end