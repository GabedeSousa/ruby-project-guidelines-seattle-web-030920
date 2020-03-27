class CreatePractices < ActiveRecord::Migration[5.0]
  def change
    create_table :practices do |t|
      
      t.string :title
      t.string :coach
      t.string :country
      t.string :practice
      
      t.timestamps
  
    end
  end
end

