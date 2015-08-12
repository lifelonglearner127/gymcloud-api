require 'rails_helper'

RSpec.describe ProgramTemplate do

  # === Relations ===
  it { is_expected.to belong_to :author}
	it { is_expected.to belong_to :folder}
  
  it { is_expected.to have_many :personal_programs}
	it { is_expected.to have_many :program_workouts}
	it { is_expected.to have_many :versions}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :description }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :is_public }
	it { is_expected.to have_db_column :author_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :folder_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["author_id"]}
	it { is_expected.to have_db_index ["folder_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :author_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end