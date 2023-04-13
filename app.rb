require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/peep_repository'
  end



  get '/' do
    return erb(:index)
  end

  get '/peeps' do
    repo = PeepRepository.new
    peeps = repo.all
    peeps.each do |message|
      return message
    end
  end

  post '/peeps' do
    repo = PeepRepository.new
    peep = Peep.new
    peep.message = params[:message]
    peep.time = params[:time]
    peep = repo.create
end


 