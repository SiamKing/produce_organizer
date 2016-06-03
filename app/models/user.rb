class User < ActiveRecord::Base

  has_many :produce

  has_secure_password

  module InstanceMethods
    def slug
      username.downcase.gsub(" ", "-")
    end
  end
  

  module ClassMethods
    def find_by_slug(slug)
      self.all.find{|instance| instance.slug == slug}
    end
  end

end
