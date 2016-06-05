require 'rack-flash'

class ProduceDatabaseController < ApplicationController

  use Rack::Flash

  get '/produce_database/edit' do
    erb :'/produce_database/edit'
  end

  patch '/produce_database/:id' do
    produce = ProduceDatabase.find(params[:id])
    if params[:name] != "" && params[:shelf_life] != ""
      produce.name = params[:name]
      produce.shelf_life = params[:shelf_life]
      produce.save
    elsif params[:name] != ""
      produce.name = params[:name]
      produce.save
    elsif params[:shelf_life] != "" && params[:shelf_life].to_i.class == Fixnum
      produce.shelf_life = params[:shelf_life]
      produce.save
    else
      flash[:notice] = "Nothing was changed. Please Edit Below"
      redirect '/produce_database/edit'
    end
    flash[:notice] = "You successfully changed the item"
    redirect '/produce_database/edit'
  end

  get '/produce_database/new' do
    erb :'/produce_database/new'
  end

end
