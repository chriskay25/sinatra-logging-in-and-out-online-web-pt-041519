require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user
      session[:user_id] = @user.id 
      redirect to('/account')
    else
      erb :error
    end
  end

  get '/account' do
    @user = User.find_by(id: session[:user_id])
    if !@user.nil?
      erb :account
    else
      erb :error
    end 
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end

