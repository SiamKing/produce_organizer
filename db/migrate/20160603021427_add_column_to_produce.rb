class AddColumnToProduce < ActiveRecord::Migration
  def change
    add_column :produce, :user_id, :integer
  end
end
