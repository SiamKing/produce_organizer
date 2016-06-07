require 'rack-flash'
class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'/index'
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def username_taken?
      User.find_by(username: params[:username])
    end

    def add_produce_to_list
      params[:produce][:name].each do |produce|
        current_user.produce << Produce.create(name: ProduceDatabase.find_by(name: produce).name, shelf_life: ProduceDatabase.find_by(name: produce).shelf_life)
      end
    end

    def signup_blank?
      params[:username] == "" || params[:email] == "" || params[:password] == ""
    end

  end

end
