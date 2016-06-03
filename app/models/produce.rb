class Produce < ActiveRecord::Base

  belongs_to :users
  belongs_to :produce_database

  def expires_in
    self.shelf_life - ((Time.now.to_i - self.created_at.to_i) / 86400)
  end

  def create_from_database
    Produce.create(name: ProduceDatabase.find_by(name: produce).name, shelf_life: ProduceDatabase.find_by(name: produce).shelf_life)
  end
end
