require 'rack-flash'

class ProduceDatabaseController < ApplicationController


  get '/produce_database/edit' do
    erb :'/produce_database/edit'
  end

  patch '/produce_database/:id' do
    #binding.pry
    if params[:name] != "" && params[:shelf_life] != ""
      produce = ProduceDatabase.find(params[:id])
      produce.name = params[:name]
      produce.shelf_life = params[:shelf_life]
      produce.update
    elsif params[:name] != ""
      produce = ProduceDatabase.find(params[:id])
      produce.name = params[:name]
      produce.update
    elsif params[:shelf_life] != ""
      produce = ProduceDatabase.find(params[:id])
      produce.shelf_life = params[:shelf_life]
      produce.update
    else
      redirect '/produce_database/edit'
    end
    flash[:notice] = "You successfully changed the item"
    redirect '/users/user'
  end


end
