class CreateDecrees < ActiveRecord::Migration
  def change
    create_table :decrees do |t|
      t.references :proceeding, null: true
      t.references :court,      null: false
      t.references :judge,      null: false
      
      t.references :decree_form
      t.references :decree_nature
            
      t.string :case_number
      t.string :file_number
      
      t.date   :date
      t.string :ecli

      t.references :legislation_area
      t.references :legislation_subarea

      t.timestamps
    end
    
    add_index :decrees, :proceeding_id
    add_index :decrees, :court_id
    add_index :decrees, :judge_id
  end
end
