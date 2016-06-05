class ProduceDatabase < ActiveRecord::Base

  belongs_to :users
  has_many :produce

end
