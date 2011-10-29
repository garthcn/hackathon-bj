module TweetsHelper
  def get_content(tweet)
    if tweet[:retweeted_status]
      tweet[:retweeted_status][:text]
    else
      tweet[:text]
    end
  end

  def get_short_content(tweet)
    truncate(get_content(tweet), :length => 50).chomp
  end
end
