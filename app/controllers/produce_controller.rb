class ProduceController < ApplicationController

  get '/produce/new' do
    if current_user
      erb :'/produce/new'
    else
      redirect '/users/login'
    end
  end

  post '/produce/new' do
    params[:produce][:name].each do |produce|
      current_user.produce << Produce.create(name: ProduceDatabase.find_by(name: produce).name, shelf_life: ProduceDatabase.find_by(name: produce).shelf_life)
    end
    redirect '/users/user'
  end

  delete '/produce/:id/delete' do
    produce = Produce.find(params[:id])
    if current_user.produce.include?(produce)
      produce.delete
    end
    redirect '/users/user'
  end

end
