class CreateProduceDatabase < ActiveRecord::Migration
  def change
    create_table :produce_database do |t|
      t.string :name
      t.integer :shelf_life
    end
  end
end
