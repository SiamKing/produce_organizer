class User < ActiveRecord::Base

  has_many :produce
  has_many :produce_database

  has_secure_password
  def self.blank?(params)
      params[:username] == "" || params[:email] == "" || params[:password] == "" 
  end

end
