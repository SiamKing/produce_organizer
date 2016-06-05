class AddColumnToProduceDatabase < ActiveRecord::Migration
  def change
    add_column :produce_database, :user_id, :integer
  end
end
