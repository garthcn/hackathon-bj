class TweetsController < ApplicationController
  before_filter :authorize, :except => :home
  # Landing Page
  def home
    if check_authorize 
      redirect_to "/tweets/index"
    else
      redirect_to "/users/welcome"
    end
  end

  # GET /tweets
  # GET /tweets.xml
  def index
    @tweets = Weibo::Base.new(@oauth).user_timeline({:count => 100})

    respond_to do |format|
      format.html { render "tweets/index" }
      format.xml  { render :xml => @tweets }
    end
  end

  def friends_timeline
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

  protected
    def group_tweets tweets
      tweets.sort! {|t1, t2| t1.created_at <=> t2.created_at}
      grouped = []
      last_time = nil
      group = []
      tweets.each do |tweet|
        t = tweet.created_at.to_i / 3600 # get hour
        if t != last_time
        end
      end
    end

end
