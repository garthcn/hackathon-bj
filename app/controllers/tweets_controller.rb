class TweetsController < ApplicationController
  before_filter :authorize, :except => :home
  TIME_SPAN = 24 * 3600
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
    @grouped_tweets = group_tweets(@tweets)

    respond_to do |format|
      format.html { render "tweets/index" }
      format.xml  { render :xml => @tweets }
    end
  end

  def friends_timeline
    @tweets = Weibo::Base.new(@oauth).friends_timeline({:count => 200})
    @grouped_tweets = group_tweets(@tweets)

    respond_to do |format|
      format.html { render "tweets/index" }
      format.xml  { render :xml => @tweets }
    end

  end    

  # GET /tweets/1
  # GET /tweets/1.xml
  def show
  end

  protected
    def group_tweets tweets
      tweets.each {|t| t.created_at = Time.parse(t.created_at).to_i}
      tweets.sort! {|t2, t1| t1.created_at <=> t2.created_at}
      grouped = []
      last_time = nil
      group = nil
      tweets.each do |tweet|
        t = tweet.created_at / TIME_SPAN # get hour
        if t != last_time
          grouped << group if group 
          group = { :time => Time.at(t * TIME_SPAN), :tweets => [] }
          group[:tweets].push tweet
          last_time = t
        else
          group[:tweets].push tweet
        end
      end
      grouped << group if group
      grouped
    end

end
