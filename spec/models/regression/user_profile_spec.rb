require 'rails_helper'

RSpec.describe UserProfile do

  # === Relations ===
  it { is_expected.to belong_to :user}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :gender }
	it { is_expected.to have_db_column :height }
	it { is_expected.to have_db_column :weight }
	it { is_expected.to have_db_column :bodyfat }
	it { is_expected.to have_db_column :first_name }
	it { is_expected.to have_db_column :last_name }
	it { is_expected.to have_db_column :location }
	it { is_expected.to have_db_column :zip }
	it { is_expected.to have_db_column :employer }
	it { is_expected.to have_db_column :birthday }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:gender).with(["female", "male"])}
  
end