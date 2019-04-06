class HikesController < ApplicationController

  # GET: /hikes
  get "/hikes" do
    @hikes = Hike.all
    erb :"/hikes/index"
  end

  # GET: /hikes/new
  get "/hikes/new" do
    erb :"/hikes/new"
  end

  # POST: /hikes
  post "/hikes" do
    redirect "/hikes"
  end

  # GET: /hikes/5
  get "/hikes/:id" do
    erb :"/hikes/show"
  end

  # GET: /hikes/5/edit
  get "/hikes/:id/edit" do
    erb :"/hikes/edit"
  end

  # PATCH: /hikes/5
  patch "/hikes/:id" do
    redirect "/hikes/:id"
  end

  # DELETE: /hikes/5/delete
  delete "/hikes/:id/delete" do
    redirect "/hikes"
  end
end
