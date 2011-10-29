class TweetsController < ApplicationController

  # Landing Page
  def home
    if authorize 
      redirect_to "/tweets/index"
    else
      redirect_to "/users/welcome"
    end
  end

  # GET /tweets
  # GET /tweets.xml
  def index
    authorize
    @tweets = Weibo::Base.new(@oauth).user_timeline

    respond_to do |format|
      format.html { render "tweets/index" }
      format.xml  { render :xml => @tweets }
    end
  end

  def friends_timeline
    authorize
    @tweets = Weibo::Base.new(@oauth).friends_timeline
    respond_to do |format|
      format.html { render "/tweets/friends_timeline" }
      format.xml  { render :xml => @tweets }
    end
  end    

  # GET /tweets/1
  # GET /tweets/1.xml
  def show

  end
end
