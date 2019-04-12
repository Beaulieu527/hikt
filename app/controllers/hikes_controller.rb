class HikesController < ApplicationController

  # GET: /hikes
  get "/hikes" do
    if logged_in?
      @hikes = Hike.all
      erb :"/hikes/index"
    else 
      redirect "/"
    end
  end

  # GET: /hikes/new
  get "/hikes/new" do
    if logged_in?
      erb :"/hikes/new"
    else 
      redirect "/"
    end 
  end

  # POST: /hikes
  post "/hikes" do
    if logged_in?
      @hike = current_user.hikes.create(name: params[:name], summary: params[:summary], location: params[:location], length: params[:length], img_url: params[:img_url])
      redirect "/hikes/#{@hike.id}"

    else 
      redirect "/"
    end
  end

  # GET: /hikes/5
  get "/hikes/:id" do
    if logged_in?
      @hike = Hike.find_by_id(params[:id])
      # binding.pry
      erb :"/hikes/show"
    else 
      redirect "/"
    end
  end

  # GET: /hikes/5/edit
  get "/hikes/:id/edit" do
    if logged_in?
      @hike = Hike.find_by_id(params[:id])
      if @hike && @hike.user == current_user
       
        erb :'hikes/edit'
      else
        redirect to '/hikes'
      end
    else 
      redirect "/"
    end
  end

  # PATCH: /hikes/5
  patch "/hikes/:id" do
    @hike = Hike.find_by_id(params[:id])
    # binding.pry
    if logged_in?
      if @hike && @hike.user == current_user
        @hike.update(
          name: params[:name], 
          summary: params[:summary], 
          location: params[:location], 
          length: params[:length], 
          img_url: params[:img_url])
        redirect "/hikes/#{@hike.id}"
      else
        redirect "/hikes/#{params[:id]}/edit"
      end
    else 
      redirect "/hikes"
    end
  end

  # DELETE: /hikes/5/delete
  delete "/hikes/:id" do
    if logged_in?
      @hike = Hike.find_by_id(params[:id])
      if @hike && @hike.user == current_user
        @hike.delete
      end
      redirect to '/hikes'
    else
      redirect to '/login'
    end
  end
end
