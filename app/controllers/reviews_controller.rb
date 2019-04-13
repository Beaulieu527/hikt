# use for a later date



class ReviewsController < ApplicationController
    # before "/*" do 
    #   set_hike
    # end

    get '/hikes/:hike_id/reviews' do 

      if logged_in?
        @reviews = @hike.reviews
        erb :'hikes/show'
      else 
        redirect '/login'
      end
    end

    # get "/hikes/:hike_id/reviews/:review_id"
    
    get '/hikes/:hike_id/reviews/new' do 
      if logged_in?
        erb :'reviews/new'
      else 
        redirect '/login'
      end
    end
    
    post '/hikes/:hike_id/reviews' do 
      if logged_in? && !params[:content].empty?
        @review = set_hike.reviews.create(content: params[:content],user_id: current_user.id)
        redirect to "/hikes/#{params[:hike_id]}"
        
      elsif logged_in? 
        redirect '/hikes/#{params[:hike_id]}'
      else
        redirect '/'
      end
    end
    
    # get '/hikes/:hike_id/reviews/:id' do 
    #   @review = @hike.reviews.find(params[:id])
    #   if logged_in?
    #     erb :'hikes/show'
    #   else
    #     redirect '/login'
    #   end
    # end
    
    get '/hikes/:hike_id/reviews/:id/edit' do 
      if logged_in?
        @review = @hike.reviews.find(params[:id])
        erb :'reviews/edit_review'
      else 
        redirect '/login'
      end
    end
    
  # if hike.id == current_hike && user.id == current_user 
  # else
  # end
  
    patch '/hikes/:hike_id/reviews/:id' do
      if logged_in?
        if params[:content] != "" 
          @review = @hike.reviews.find(params[:id])
          @review.update(content: params[:content])
          redirect "/hikes/#{params[:hike_id]}"
        else
          redirect "/hikes/#{params[:hike_id]}/#{params[:id]}/edit"
        end
      else 
        redirect '/login'
      end
    end
    
    delete '/hikes/:hike_id/reviews/:id' do
      @review = @hike.reviews.find(params[:id])
      if logged_in? && current_user.id == @review.user_id
          @review.delete
          redirect '/hikes/#{params[:hike_id]}'
      else
          redirect "/login"
      end
    end

    private
      def set_hike
        @hike = Hike.find(params[:hike_id])
      end
  end