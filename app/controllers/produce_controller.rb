require 'rack-flash'

class ProduceController < ApplicationController

  use Rack::Flash

  get '/produce/new' do
    if current_user
      erb :'/produce/new'
    else
      flash[:notice] = "Please Log In"
      redirect '/users/login'
    end
  end

  post '/produce' do
    add_produce_to_list #helper method
    flash[:notice] = "You successfully added items to your fridge!"
    redirect '/users/user'
  end

  post '/produce/new' do
    if produce = ProduceDatabase.find_by(name: params[:name])
      current_user.produce << Produce.create(name: produce.name, shelf_life: produce.shelf_life)
      flash[:notice] = "Your item was successfully added to your list"
      redirect '/users/user'
    else
       if current_user
        if params[:name] != "" && params[:shelf_life].to_i > 0
          produce = ProduceDatabase.create(name: params[:name].capitalize, shelf_life: params[:shelf_life], user_id: current_user.id)
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
    produce = Produce.find(params[:id])
    if current_user.produce.include?(produce)
      produce.delete
      flash[:notice] = "Item was removed from your fridge"
      redirect '/users/user'
    end
    flash[:notice] = "That item was not yours to remove!"
    redirect '/users/user'
  end


end
