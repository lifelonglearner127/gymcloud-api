class CreateProgramTemplates < ActiveRecord::Migration
  def change
    create_table :program_templates do |t|
      t.string :name
      t.text :description
      t.text :note
      t.boolean :is_public
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
