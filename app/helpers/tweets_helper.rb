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

  def get_all_content(tweet)
    html = ""
    html << tweet.text
    html << "<div class='well' style='margin-top:15px'>#{tweet.retweeted_status.text}</div>" if tweet.retweeted_status
    html
  end
end
