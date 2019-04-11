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
      @hike = Hike.create(name: params[:name], summary: params[:summary], location: params[:location], length: params[:length], img_url: params[:img_url])
      redirect "/hikes/#{@hike.id}"
    else 
      redirect "/"
    end
  end

  # GET: /hikes/5
  get "/hikes/:id" do
    if logged_in?
      @hike = Hike.find(params[:id])
      # binding.pry
      erb :"/hikes/show"
    else 
      redirect "/"
    end
  end

  # GET: /hikes/5/edit
  get "/hikes/:id/edit" do
    if logged_in?
      @hike = Hike.find(params[:id])
      erb :"/hikes/edit"
    else 
      redirect "/"
    end
  end

  # PATCH: /hikes/5
  patch "/hikes/:id" do
    @hike = Hike.find_by(params[:id])
    if logged_in? && current_user ==@hike.user
      if  params[:name] != "" && params[:summary] != "" && params[:location] != "" && params[:length] != "" && params[:img_url] != ""
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
      redirect "/"
    end
  end

  # DELETE: /hikes/5/delete
  delete "/hikes/:id/delete" do
    @hike = Hike.find(params[:id])
    if current_user == @hike.user
        @hike.destroy
        redirect '/hikes'
    else
        redirect "/hikes/#{@hike.id}"
    end
end
  end
