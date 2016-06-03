class ProduceController < ApplicationController

  get '/produce/new' do
    if current_user
      erb :'/produce/new'
    else
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
      redirect '/users/user' # log message - successfully created
    else
      if current_user
        if params[:name] != "" && params[:shelf_life].to_i.class == Fixnum
          produce = ProduceDatabase.create(name: params[:name], shelf_life: params[:shelf_life])
          current_user.produce << Produce.create(name: produce.name, shelf_life: produce.shelf_life)
          redirect '/users/user' #log message = successfully created
        else
          redirect '/produce/new' # log message - please fill out form correctly
        end
      else
        redirect '/users/login' # flash message - please login
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
