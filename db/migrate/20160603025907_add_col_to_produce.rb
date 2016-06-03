class AddColToProduce < ActiveRecord::Migration
  def change
    add_column :produce, :produce_database_id, :integer
  end
end
