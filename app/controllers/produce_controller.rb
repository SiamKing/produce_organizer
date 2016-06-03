require 'rack-flash'

class ProduceController < ApplicationController

  get '/produce/new' do
    if current_user
      erb :'/produce/new'
    else
      flash[:notice] = "Please Log In"
      redirect '/users/login'
    end
  end

  post '/produce' do
    params[:produce][:name].each do |produce|
      current_user.produce << Produce.create(name: ProduceDatabase.find_by(name: produce).name, shelf_life: ProduceDatabase.find_by(name: produce).shelf_life)
    end
    redirect '/users/user'
  end

  post '/produce/new' do
    if produce = ProduceDatabase.find_by(name: params[:name])
      current_user.produce << Produce.create(name: produce.name, shelf_life: produce.shelf_life)
      flash[:notice] = "Your item added to your list"
      redirect '/users/user'
    else
      if current_user
        if params[:name] != "" && params[:shelf_life].to_i.class == Fixnum
          produce = ProduceDatabase.create(name: params[:name], shelf_life: params[:shelf_life])
          current_user.produce << Produce.create(name: produce.name, shelf_life: produce.shelf_life)
          flash[:notice] = "Your item was successfully created and added to your fridge"
          redirect '/users/user'
        else
          flash[:notice] = "The form was not filled out correctly. Please try again."
          redirect '/produce/new'
        end
      else
        flash[:notice] = "Please Log In"
        redirect '/users/login' 
      end
    end

  end

  delete '/produce/:id/delete' do
    @produce = Produce.find(params[:id])
    if current_user.produce.include?(produce)
      produce.delete
    end
    redirect '/users/user' # flash message - @produce removed
  end

end
