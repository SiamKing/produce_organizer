class Produce < ActiveRecord::Base

  belongs_to :users
  belongs_to :produce_database

  def expires_in
    self.shelf_life - ((Time.now.to_i - self.created_at.to_i) / 86400)
  end

end
