class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.integer :user_id
      t.integer :status, default: 0
      t.string :file

      t.timestamps null: false
    end

    add_index :certificates, :user_id, unique: true
  end
end
