class CreatePresets < ActiveRecord::Migration
  def change
    create_table :presets do |t|
      t.string :name
      t.references :user, index: true, foreign_key: true
      t.references :folder, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
