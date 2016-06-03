class UsersController < ApplicationController

  get '/users/signup' do
    if current_user
      redirect '/users/user'
    else
      erb :'/users/signup'
    end
  end

  post '/users/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/users/signup', locals: {message: "Please fill out all of the fields"}
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/users/user'
    end
  end

  get '/users/login' do
    erb :'/users/login'
  end

  post '/users/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect'/users/user'
    else
      redirect '/users/login'
    end
  end

  get '/users/user' do
    @user = current_user
    erb :'/users/user'
  end

  get '/users/logout' do
    if logged_in?
      session.clear
      redirect '/users/login'
    else
      redirect '/'
    end
  end

end
