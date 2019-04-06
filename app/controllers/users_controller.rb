class UsersController < ApplicationController
  get "/signup" do 
    if logged_in?
        redirect "/hikes"
    else
        erb :"users/signup"
    end
    
  end 

  
  post '/signup' do 
    if logged_in?
      if params[:username] != "" && params[:password] != "" && params[:email] != ""
          if User.find_by(username: params[:username]) && User.find_by(email: params[:email])
          
          else 
              @user = User.create(username: params[:username], email: params[:email], password: params[:password])
              session[:user_id] = user.id
          end 
          redirect "/hikes"
      else
          redirect "/signup"
      end
    else 
      redirect "/hikes"
    end 
  end 

  
  get '/login' do 
    if !logged_in?
      erb :'/users/login'
    else
      redirect '/signup'
    end
  end
  
  post '/login' do 
    if !logged_in?
      @user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/hikes"
      else
          redirect "/login"
      end
    else 
      redirect "/hikes"
    end 
  end
  
  
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    if @user 
      @reviews = @user.reviews
      erb :'users/show'
    else
      redirect '/'
    end
  end
  
  get '/logout' do 
  
    session.clear
    if !logged_in?
      redirect '/login'
    end
  end
end
