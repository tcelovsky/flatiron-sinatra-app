class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      # make_events
      erb :"events/index"
    else redirect to :"/login"
    end
  end

  get '/events/new' do
    if logged_in?
      erb :"events/new"
    else redirect to :"/login"
    end
  end

  post '/events/new' do
    if params[:name].present? && params[:description].present? && params[:website].present?
      @user = current_user
      @event = Event.create(name: params[:name], description: params[:description], website: params[:website])
      @event.user_id = @user.id
      @event.save
      erb :"/events/index"
    else redirect to :"/events/new"
    end
  end

  get '/events/:id' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      erb :"events/show"
    else redirect to :"/login"
    end
  end

  delete '/events/:id/delete' do
    if logged_in?
      @event = Event.find_by(params[:name])
      @event.delete
      erb :"/events/index"
    else redirect to :"/login"
    end
  end

  get '/events/:id/edit' do
    if logged_in?
      @event = Event.find_by_id(params[:id])
      erb :"/events/edit"
    else redirect to :"/login"
    end
  end

  patch '/events/:id/edit' do
    if params[:name].present? && params[:description].present? && params[:website].present?
      @event.name = params[:name]
      @event.description = params[:description]
      @event.website = params[:website]
      @event.save
      erb :"/events/index"
    else erb :"/events/edit"
    end
  end
end
