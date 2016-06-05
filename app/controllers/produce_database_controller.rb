require 'rack-flash'

class ProduceDatabaseController < ApplicationController


    get '/produce_database/edit' do
      erb :'/produce_database/edit'
    end


end
