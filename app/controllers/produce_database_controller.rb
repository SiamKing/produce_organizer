require 'rack-flash'

class ProduceDatabaseController < ApplicationController

  use Rack::Flash

  get '/produce_database/edit' do
    if logged_in?
      erb :'/produce_database/edit'
    else
      flash[:notice] = "Please log in"
      redirect '/users/login'
    end
  end

  patch '/produce_database/:id' do
    produce = produce_id #helper method
    if current_user.id == produce.user_id
      if params[:name] != "" && params[:shelf_life].to_i > 0
        produce.name = params[:name]
        produce.shelf_life = params[:shelf_life]
      elsif params[:name] != ""
        produce.name = params[:name]
      elsif params[:shelf_life].to_i > 0
        produce.shelf_life = params[:shelf_life]
      else
        if params[:shelf_life] != ""
          flash[:notice] = "Please enter a number greater than 0 for shelf life"
        else
          flash[:notice] = "Nothing was changed. Please Edit Below"
        end
        redirect '/produce_database/edit'
      end
    else
      flash[:notice] = "Only the user that created the item can edit it."
      redirect '/users/user'
    end
    produce.save
    flash[:notice] = "You successfully changed the item"
    redirect '/produce_database/edit'
  end

  get '/produce_database/new' do
    erb :'/produce_database/new'
  end

  post '/produce_database/new' do
    if params[:name] == "" || params[:shelf_life] == ""
      flash[:notice] = "Please fill out both fields to add item to database"
    else
      if produce = ProduceDatabase.find_by(name: params[:name].capitalize)
        flash[:notice] = "Item already exists. "
      else
        ProduceDatabase.create(name: params[:name].capitalize, shelf_life: params[:shelf_life], user_id: current_user.id)
        flash[:notice] = "Item was successfully added"
      end
    end
    redirect '/produce_database/new'
  end

  get '/produce_database/delete' do
    if current_user.id == 6
      erb :'/produce_database/delete'
    else
      flash[:notice] = "You do not have permission to see that page"
      redirect '/users/user'
    end
  end

  delete '/produce_database/:id/delete' do
    if current_user.id == 6
      produce_id.delete
      flash[:notice] = "You successfully deleted item from the database"
    else
      flash[:notice] = "You do not have permission to delete item from database"
    end
    redirect '/users/user'
  end

  private

  def produce_id
    ProduceDatabase.find(params[:id])
  end

end
