class CreateProduce < ActiveRecord::Migration
  def change
    create_table :produce do |t|
      t.string :name
      t.integer :shelf_life
      t.datetime :created_at
      
    end
  end
end
