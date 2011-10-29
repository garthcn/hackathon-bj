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

    if tweet.thumbnail_pic
      html << "<br />"
      html << image_tag(tweet.bmiddle_pic, :id => "popover-thumb", :alt => tweet.original_pic)
    end
    
    if tweet.retweeted_status
      html << "<div class='well' style='margin-top:15px'>"
      html << "#{tweet.retweeted_status.text}"
      if tweet.retweeted_status.thumbnail_pic
        html << "<br />"
        html << image_tag(tweet.retweeted_status.bmiddle_pic, :id => "popover-thumb", :alt => tweet.retweeted_status.original_pic)
      end
      html << "</div>" 
    end

    html
  end
end
